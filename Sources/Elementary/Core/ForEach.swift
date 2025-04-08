/// An element that lazily renders HTML for each element in a sequence.
///
/// Using `ForEach` instead of `for ... in` is potentially more efficient when rendering a large number of elements,
/// as the result does not need to be collected into an array before rendering.
///
/// ```swift
/// ForEach(1 ... 100) { index in
///    li { "Item \(index)" }
/// }
/// ```
public struct ForEach<Data, Content>: HTML
where Data: Sequence, Content: HTML {
    public var _data: Data
    // TODO: Swift 6 - @Sendable is not ideal here, but currently the response generators for hummingbird/vapor require sendable HTML types
    // also, currently there is no good way to conditionally apply Sendable conformance based on closure type

    public var _contentBuilder: @Sendable (Data.Element) -> Content

    /// Creates a new `ForEach` element with the given sequence and content builder closure.
    ///
    /// - Parameters:
    ///  - sequence: A sequence of data to render.
    ///  - contentBuilder: A closure that builds the HTML content for each element in the sequence.
    public init(_ data: Data, @HTMLBuilder content contentBuilder: @escaping @Sendable (Data.Element) -> Content) {
        _data = data
        _contentBuilder = contentBuilder
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        for element in html._data {
            Content._render(html._contentBuilder(element), into: &renderer, with: copy context)
        }
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        for element in html._data {
            try await Content._render(html._contentBuilder(element), into: &renderer, with: copy context)
        }
    }
}

extension ForEach: Sendable where Data: Sendable {}
