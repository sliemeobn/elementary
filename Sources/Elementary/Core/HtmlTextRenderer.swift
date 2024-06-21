// NOTE: an async version of this could be interesteing, where the components content can by asnc, and the renderer is an async stream... probably a bit complex though
// TODO: clean this up a bit

struct HTMLTextRenderer: _HTMLRendering {
    private var result: String = ""
    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        result += token.renderedValue
    }

    consuming func collect() -> String { result }
}

struct HTMLStreamRenderer: _HTMLRendering {
    let writer: (String) -> Void

    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        writer(token.renderedValue)
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
        let renderedToken = token.renderedValue

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
    var renderedValue: String {
        switch self {
        case let .startTagOpen(tagName, _):
            return "<\(tagName)"
        case let .attribute(name, value):
            if let value = value {
                return " \(name)=\"\(value.htmlEscaped(for: .attribute))\""
            } else {
                return " \(name)"
            }
        case .startTagClose:
            return ">"
        case let .endTag(tagName, _):
            return "</\(tagName)>"
        case let .text(text):
            return text.htmlEscaped(for: .content)
        case let .raw(raw):
            return raw
        case let .comment(comment):
            return "<!--\(comment.htmlEscaped(for: .content))-->"
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

extension String {
    enum HTMLEscapingMode {
        case attribute
        case content
    }

    func htmlEscaped(for mode: HTMLEscapingMode) -> String {
        var result = [UInt8]()
        result.reserveCapacity(utf8.count)

        // Iterate over each UTF-8 code unit in the string
        for byte in utf8 {
            switch (byte, mode) {
            case (38, _): // &
                result.append(contentsOf: "&amp;".utf8)
            case (34, .attribute): // "
                result.append(contentsOf: "&quot;".utf8)
            case (60, .content): // <
                result.append(contentsOf: "&lt;".utf8)
            case (62, .content): // >
                result.append(contentsOf: "&gt;".utf8)
            default:
                result.append(byte)
            }
        }

        // Convert the UTF-8 byte array back to a String
        return String(decoding: result, as: UTF8.self)
    }
}
