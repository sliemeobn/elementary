extension _HTMLRenderToken {
    // NOTE: consuming get causes complier error, but won't make a difference likely
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

private extension String {
    enum HTMLEscapingMode {
        case attribute
        case content
    }

    func htmlEscaped(for mode: HTMLEscapingMode) -> String {
        var result = [UInt8]()
        result.reserveCapacity(utf8.count)

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

        return String(decoding: result, as: UTF8.self)
    }
}

extension _RenderingContext {
    @inline(__always)
    func assertNoAttributes(_ type: (some HTML).Type) {
        assert(attributes.isEmpty, "Attributes are not supported on \(type)")
    }

    @inline(__always)
    func assertionFailureNoAsyncContext(_ type: (some HTML).Type) {
        let message = "Cannot render \(type) in a synchronous context, please use .render(into:) or .renderAsync() instead."
        print("Elementary rendering error: \(message)")
        assertionFailure(message)
    }
}

// NOTE: weirdly, using string interpolation tokens is faster than appending to the buffer directly. keeping this here for future experiments
// extension [UInt8] {
//     @inline(__always)
//     mutating func append(_ string: String) {
//         append(contentsOf: string.utf8)
//     }

//     mutating func appendToken(_ token: consuming _HTMLRenderToken) {
//         // avoid strings and append each component directly
//         switch token {
//         case let .startTagOpen(tagName, _):
//             append("<")
//             append(tagName)
//         case let .attribute(name, value):
//             append(" ")
//             append(name)
//             if let value = value {
//                 append("=")
//                 append("\"")
//                 append(value.htmlEscaped(for: .attribute))
//                 append("\"")
//             }
//         case .startTagClose:
//             append(">")
//         case let .endTag(tagName, _):
//             append("</")
//             append(tagName)
//             append(">")
//         case let .text(text):
//             append(text.htmlEscaped(for: .content))
//         case let .raw(raw):
//             append(raw)
//         case let .comment(comment):
//             append("<!--")
//             append(comment.htmlEscaped(for: .content))
//             append("-->")
//         }
//     }
// }
