/// An element that lazily renders HTML for each element of an `AsyncSequence`.
///
/// The this element can only be rendered in an async context (ie: by calling ``HTML/render(into:chunkSize:)`` or ``HTML/renderAsync()``).
///
/// ```swift
/// let users = try await db.users.findAll()
/// ul {
///   AsyncForEach(users) { user in
///     li { "\(user.name) \(user.favoriteProgrammingLanguage)" }
///   }
/// }
/// ```
public struct AsyncForEach<Source: AsyncSequence, Content: HTML>: HTML {
    var sequence: Source
    var contentBuilder: (Source.Element) -> Content

    /// Creates a new async HTML element that renders the specified content for each element of the sequence.
    ///
    /// - Parameters:
    ///   - sequence: An `AsyncSequence` of data to render.
    ///   - contentBuilder: A closure that builds the HTML content for each element in the sequence.
    public init(_ sequence: Source, @HTMLBuilder contentBuilder: @escaping (Source.Element) -> Content) {
        self.sequence = sequence
        self.contentBuilder = contentBuilder
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertionFailureNoAsyncContext(self)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)

        for try await element in html.sequence {
            try await Content._render(html.contentBuilder(element), into: &renderer, with: copy context)
        }
    }
}
