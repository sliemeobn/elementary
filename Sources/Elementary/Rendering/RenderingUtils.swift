extension _RenderingContext {
    @inline(__always)
    @usableFromInline
    func assertNoAttributes(_ type: (some _BaseHTML).Type) {
        #if hasFeature(Embedded)
        assert(attributes.isEmpty, "Attributes are not supported")
        #else
        assert(attributes.isEmpty, "Attributes are not supported on \(type)")
        #endif
    }
}

// I do not know why this function does not work in embedded, but currently it crashes the compiler
#if !hasFeature(Embedded)
extension [UInt8] {
    @inline(__always)
    mutating func appendToken(_ token: consuming _HTMLRenderToken) {
        // avoid strings and append each component directly
        switch token {
        case let .startTag(tagName, attributes: attributes, isUnpaired: _, type: _):
            append(60)  // <
            appendString(tagName)
            if !attributes.isEmpty {
                for attribute in attributes {
                    append(32)  // space
                    appendString(attribute.name)
                    if let value = attribute.value {
                        append(contentsOf: [61, 34])  // ="
                        appendEscapedAttributeValue(value)
                        append(34)  // "
                    }
                }
            }
            append(62)  // >
        case let .endTag(tagName, _):
            append(contentsOf: [60, 47])  // </
            appendString(tagName)
            append(62)  // >
        case let .text(text):
            appendEscapedText(text)
        case let .raw(raw):
            appendString(raw)
        case let .comment(comment):
            appendString("<!--")
            appendEscapedText(comment)
            appendString("-->")
        }
    }

    @inline(__always)
    mutating func appendString(_ string: consuming String) {
        string.withUTF8 { utf8 in
            append(contentsOf: utf8)
        }
    }

    @inline(__always)
    mutating func appendEscapedAttributeValue(_ value: consuming String) {
        value.withUTF8 { utf8 in
            var start = utf8.startIndex

            for current in utf8.indices {
                switch utf8[current] {
                case 38:  // &
                    append(contentsOf: utf8[start..<current])
                    appendString("&amp;")
                    start = utf8.index(after: current)
                case 34:  // "
                    append(contentsOf: utf8[start..<current])
                    appendString("&quot;")
                    start = utf8.index(after: current)
                default:
                    ()
                }
            }

            if start < utf8.endIndex {
                append(contentsOf: utf8[start..<utf8.endIndex])
            }
        }
    }

    @inline(__always)
    mutating func appendEscapedText(_ value: consuming String) {
        value.withUTF8 { utf8 in
            var start = utf8.startIndex

            for current in utf8.indices {
                switch utf8[current] {
                case 38:  // &
                    append(contentsOf: utf8[start..<current])
                    appendString("&amp;")
                    start = utf8.index(after: current)
                case 60:  // <
                    append(contentsOf: utf8[start..<current])
                    appendString("&lt;")
                    start = utf8.index(after: current)
                case 62:  // >
                    append(contentsOf: utf8[start..<current])
                    appendString("&gt;")
                    start = utf8.index(after: current)
                default:
                    ()
                }
            }

            if start < utf8.endIndex {
                append(contentsOf: utf8[start..<utf8.endIndex])
            }
        }
    }
}
#endif
