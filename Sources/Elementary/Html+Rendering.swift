public extension HTML {
    consuming func render() -> String {
        var renderer = HTMLTextRenderer()
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }

    consuming func renderFormatted() -> String {
        var renderer = PrettyHTMLTextRenderer(spaces: 2)
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }

    @available(*, deprecated, message: "will be removed, use async API render(into:chunkSize:) instead")
    consuming func render(into writer: @escaping (String) -> Void) {
        var renderer = HTMLStreamRenderer(writer: writer)
        Self._render(self, into: &renderer, with: .emptyContext)
    }

    consuming func render(into writer: some HTMLStreamWriter, chunkSize: Int = 1024) async throws {
        var renderer = AsyncHTMLRenderer(writer: writer, chunkSize: chunkSize)
        try await Self._render(self, into: &renderer, with: .emptyContext)
        try await renderer.flush()
    }

    consuming func renderAsync() async throws -> String {
        let writer = BufferWriter()
        try await render(into: writer)
        return String(decoding: writer.result, as: UTF8.self)
    }
}

public protocol HTMLStreamWriter {
    func write(_ bytes: ArraySlice<UInt8>) async throws
}
