extension _RenderingContext {
    @inline(__always)
    @usableFromInline
    func assertNoAttributes(_ type: (some HTML).Type) {
        #if hasFeature(Embedded)
        assert(attributes.isEmpty, "Attributes are not supported")
        #else
        assert(attributes.isEmpty, "Attributes are not supported on \(type)")
        #endif
    }

    @inline(__always)
    @usableFromInline
    func assertionFailureNoAsyncContext(_ type: (some HTML).Type) {
        let message = "Cannot render \(type) in a synchronous context, please use .render(into:) or .renderAsync() instead."
        print("Elementary rendering error: \(message)")
        #if !hasFeature(Embedded)
        assertionFailure(message)
        #endif
    }
}

// I do not know why this function does not work in embedded, but currently it crashes the compiler
#if !hasFeature(Embedded)
extension [UInt8] {
    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        // avoid strings and append each component directly
        switch token {
        case let .startTag(tagName, attributes: attributes, isUnpaired: _, type: _):
            append(60) // <
            append(contentsOf: tagName.utf8)
            for attribute in attributes {
                append(32) // space
                append(contentsOf: attribute.name.utf8)
                if let value = attribute.value {
                    append(contentsOf: [61, 34]) // ="
                    appendEscapedAttributeValue(value)
                    append(34) // "
                }
            }
            append(62) // >
        case let .endTag(tagName, _):
            append(contentsOf: [60, 47]) // </
            append(contentsOf: tagName.utf8)
            append(62) // >
        case let .text(text):
            appendEscapedText(text)
        case let .raw(raw):
            append(contentsOf: raw.utf8)
        case let .comment(comment):
            append(contentsOf: "<!--".utf8)
            appendEscapedText(comment)
            append(contentsOf: "-->".utf8)
        }
    }

    mutating func appendEscapedAttributeValue(_ value: consuming String) {
        for byte in value.utf8 {
            switch byte {
            case 38: // &
                append(contentsOf: "&amp;".utf8)
            case 34: // "
                append(contentsOf: "&quot;".utf8)
            default:
                append(byte)
            }
        }
    }

    mutating func appendEscapedText(_ value: consuming String) {
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
}
#endif
