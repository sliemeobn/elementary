public struct AsyncHTML<Content: HTML>: HTML, Sendable {
    var content: @Sendable () async throws -> Content
    public typealias Tag = Content.Tag

    public init(@HTMLBuilder content: @escaping @Sendable () async throws -> Content) {
        self.content = content
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertionFailureNoAsyncContext(self)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        try await Content._render(await html.content(), into: &renderer, with: context)
    }
}
