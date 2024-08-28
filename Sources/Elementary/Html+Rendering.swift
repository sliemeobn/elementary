public extension HTML {
    /// Renders the HTML content into a single string.
    /// - Returns: The rendered HTML content.
    ///
    /// This method is synchronous and collects the entire rendered content into a single string.
    /// For server applications, use the async API ``render(into:chunkSize:)`` instead.
    consuming func render() -> String {
        var renderer = HTMLTextRenderer()
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }

    /// Renders the HTML content into a formatted string.
    /// - Returns: The rendered HTML content.
    ///
    /// Should only be used for testing and debugging purposes.
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

    /// Renders the HTML content into a stream writer.
    /// - Parameters:
    ///   - writer: The ``HTMLStreamWriter`` to write the rendered content to.
    ///   - chunkSize: The maximum size of the chunks to write to the stream.
    ///
    /// This is the primary API for server-side applications to stream HTML content in HTTP responses.
    consuming func render(into writer: some HTMLStreamWriter, chunkSize: Int = 1024) async throws {
        var renderer = AsyncHTMLRenderer(writer: writer, chunkSize: chunkSize)
        try await Self._render(self, into: &renderer, with: .emptyContext)
        try await renderer.flush()
    }

    /// Renders the HTML content into a single string asynchronously.
    /// - Returns: The rendered HTML content.
    ///
    /// Only intended for testing purposes.
    consuming func renderAsync() async throws -> String {
        let writer = BufferWriter()
        try await render(into: writer)
        return String(decoding: writer.result, as: UTF8.self)
    }
}

/// A type that write chunks of HTML content to a stream.
///
/// Conform to this protocol to stream HTML responses efficiently.
public protocol HTMLStreamWriter {
    /// Writes a chunk of rendered HTML.
    mutating func write(_ bytes: ArraySlice<UInt8>) async throws
}
