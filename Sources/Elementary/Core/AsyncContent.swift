/// An element that awaits its content before rendering.
///
/// The this element can only be rendered in an async context (ie: by calling ``HTML/render(into:chunkSize:)`` or ``HTML/renderAsync()``).
/// All HTML tag types (``HTMLElement``) support async content closures in their initializers, so you don't need to use this element directly in most cases.
public struct AsyncContent<Content: HTML>: HTML, Sendable {
    public typealias Body = Never
    public typealias Tag = Content.Tag

    @usableFromInline
    var content: @Sendable () async throws -> Content

    /// Creates a new async HTML element with the specified content.
    ///
    /// - Parameters:
    ///   - content: The future content of the element.
    ///
    /// ```swift
    /// AsyncContent {
    ///    let value = await fetchValue()
    ///   "Waiting for "
    ///    span { value }
    /// }
    /// ```
    public init(@HTMLBuilder content: @escaping @Sendable () async throws -> Content) {
        self.content = content
    }

    @inlinable
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertionFailureNoAsyncContext(self)
    }

    @inlinable
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        try await Content._render(await html.content(), into: &renderer, with: context)
    }
}
