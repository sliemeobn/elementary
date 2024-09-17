struct HTMLTextRenderer: _HTMLRendering {
    private var result: [UInt8] = []

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

    private var result: String = ""
    private var currentIndentation: String = ""
    private var currentTokenContext = _HTMLRenderToken.RenderingType.block
    private var currentInlineText = ""
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

        if token.shouldInline(currentlyInlined: isInLineAfterBlockTagOpen || !currentInlineText.isEmpty) {
            if !isInLineAfterBlockTagOpen {
                addLineBreak()
            }

            currentInlineText += renderedToken
        } else {
            switch token {
            case .startTagOpen:
                flushInlineText(forceLineBreak: isInLineAfterBlockTagOpen)
                addLineBreak()
                result += renderedToken
                increaseIndentation()
            case let .startTagClose(isUnpaired):
                assert(currentInlineText.isEmpty, "unexpected inline text \(currentInlineText)")

                result += renderedToken

                if isUnpaired {
                    decreaseIndentation()
                    isInLineAfterBlockTagOpen = false
                } else {
                    isInLineAfterBlockTagOpen = true
                }
            case .endTag:
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
            case .attribute:
                assert(currentInlineText.isEmpty, "unexpected inline text \(currentInlineText)")
                result += renderedToken
            default:
                assertionFailure("unexpected rendering case for \(renderedToken)")
                flushInlineText()
                result += renderedToken
            }
        }
    }
}

extension _HTMLRenderToken {
    func shouldInline(currentlyInlined: Bool) -> Bool {
        switch self {
        case .startTagOpen(_, .inline), .endTag(_, .inline), .text, .raw, .comment:
            return true
        case .attribute, .startTagClose:
            return currentlyInlined
        default:
            return false
        }
    }
}
