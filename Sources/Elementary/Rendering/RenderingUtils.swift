extension _HTMLRenderToken {
    // TODO: remove this method
    func renderedValue() -> String {
        var buffer: [UInt8] = []
        buffer.appendToken(self)
        return String(decoding: buffer, as: UTF8.self)
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

extension [UInt8] {
    mutating func writeEscapedAttribute(_ value: consuming String) {
        for byte in value.utf8 {
            switch byte {
            case 38: // &
                self.append(contentsOf: "&amp;".utf8)
            case 34: // "
                append(contentsOf: "&quot;".utf8)
            default:
                append(byte)
            }
        }
    }

    mutating func writeEscapedContent(_ value: consuming String) {
        for byte in value.utf8 {
            switch byte {
            case 38: // &
                append(contentsOf: "&amp;".utf8)
            case 60: // <
                append(contentsOf: "&lt;".utf8)
            case 62: // >
                append(contentsOf: "&gt;".utf8)
            default:
                append(byte)
            }
        }
    }

    mutating func append(tag: StaticString) {
        tag.withUTF8Buffer { buffer in
            append(contentsOf: buffer)
        }
    }

    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        // avoid strings and append each component directly
        switch token {
        case let .startTag(tagName, attributes: attributes, isUnpaired: _, type: _):
            append(60) // <
            append(tag: tagName)
            for attribute in attributes.flattened() {
                append(32) // space
                append(contentsOf: attribute.name.utf8)
                if let value = attribute.value {
                    append(contentsOf: [61, 34]) // ="
                    writeEscapedAttribute(value)
                    append(34) // "
                }
            }
            append(62) // >
        case let .endTag(tagName, _):
            append(contentsOf: [60, 47]) // </
            append(tag: tagName)
            append(62) // >
        case let .text(text):
            writeEscapedContent(text)
        case let .raw(raw):
            append(contentsOf: raw.utf8)
        case let .comment(comment):
            append(contentsOf: "<!--".utf8)
            writeEscapedContent(comment)
            append(contentsOf: "-->".utf8)
        }
    }
}
