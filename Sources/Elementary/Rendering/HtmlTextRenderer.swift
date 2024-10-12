#if !hasFeature(Embedded)
struct HTMLTextRenderer: _HTMLRendering {
    private var result: [UInt8] = []

    init() {
        // gotta start somewhere
        result.reserveCapacity(1024)
    }

    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        result.appendToken(token)
    }

    consuming func collect() -> String {
        String(decoding: result, as: UTF8.self)
    }
}

@available(*, deprecated, message: "will be removed")
struct HTMLStreamRenderer: _HTMLRendering {
    let writer: (String) -> Void

    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        writer(token.renderedValue())
    }
}

struct PrettyHTMLTextRenderer {
    let indentation: String

    init(spaces: Int) {
        indentation = String(repeating: " ", count: spaces)
    }

    private var result = ""
    private var currentIndentation = ""
    private var currentInlineText = ""
    private var currentTokenContext = _HTMLRenderToken.RenderingType.block
    private var isInLineAfterBlockTagOpen = false

    consuming func collect() -> String {
        flushInlineText()
        return result
    }

    mutating func increaseIndentation() {
        currentIndentation += indentation
    }

    mutating func decreaseIndentation() {
        assert(currentIndentation.hasSuffix(indentation), "invalid indentation state")
        currentIndentation.removeLast(indentation.count)
    }

    mutating func addLineBreak() {
        guard !result.isEmpty else { return }
        result += "\n"
        result += currentIndentation
    }

    @discardableResult
    mutating func flushInlineText(forceLineBreak: Bool = false) -> Bool {
        isInLineAfterBlockTagOpen = false
        guard !currentInlineText.isEmpty else { return false }

        defer {
            currentInlineText = ""
        }

        if currentInlineText.contains("\n") {
            currentInlineText.replace("\n", with: "\n\(currentIndentation)")
            addLineBreak()
            result += currentInlineText
            return true
        } else if forceLineBreak {
            addLineBreak()
            result += currentInlineText
            return true
        } else {
            result += currentInlineText
            return false
        }
    }
}

extension PrettyHTMLTextRenderer: _HTMLRendering {
    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        let renderedToken = token.renderedValue()

        switch token {
        case let .startTag(_, attributes: _, isUnpaired: isUnpaired, type: type):
            switch type {
            case .inline:
                currentInlineText += renderedToken
            case .block:
                flushInlineText(forceLineBreak: isInLineAfterBlockTagOpen)
                addLineBreak()
                result += renderedToken

                if isUnpaired {
                    isInLineAfterBlockTagOpen = false
                } else {
                    increaseIndentation()
                    isInLineAfterBlockTagOpen = true
                }
            }
        case let .endTag(_, type):
            switch type {
            case .inline:
                currentInlineText += renderedToken
            case .block:
                var shouldLineBreak = false

                if isInLineAfterBlockTagOpen {
                    let hasBroken = flushInlineText()
                    shouldLineBreak = hasBroken
                } else {
                    flushInlineText()
                    shouldLineBreak = true
                }

                decreaseIndentation()

                if shouldLineBreak {
                    addLineBreak()
                }

                result += renderedToken
            }
        case .text, .raw, .comment:
            if isInLineAfterBlockTagOpen {
                currentInlineText += renderedToken
            } else {
                addLineBreak()
                result += renderedToken
            }
        }
    }
}

private extension _HTMLRenderToken {
    // TODO: remove this method
    func renderedValue() -> String {
        var buffer: [UInt8] = []
        buffer.appendToken(self)
        return String(decoding: buffer, as: UTF8.self)
    }
}

#endif
