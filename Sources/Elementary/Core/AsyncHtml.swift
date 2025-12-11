#if !hasFeature(Embedded)
/// A type that represents HTML content that can be rendered asynchronously.
///
/// You can create reusable Async HTML components by conforming to this protocol
/// and implementing the ``body`` property.
///
/// ```swift
/// struct FeatureList: AsyncHTML {
///   var features: [String]
///
///   var body: some AsyncHTML {
///     ul {
///       for await feature in features {
///         li { feature }
///       }
///     }
///   }
/// }
/// ```
public protocol AsyncHTML<Tag> {
    /// The HTML tag this component represents, if any.
    ///
    /// The Tag type defines which attributes can be attached to an HTML element.
    /// If an element does not represent a specific HTML tag, the Tag type will
    /// be ``Swift/Never`` and the element cannot be attributed.
    associatedtype Tag: HTMLTagDefinition = Body.Tag

    /// The type of the HTML content this component represents.
    associatedtype Body: AsyncHTML

    /// The HTML content of this component.
    @HTMLBuilder var body: Body { get }

    static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws
}

extension AsyncHTML {
    @inlinable
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        try await Body._render(html.body, into: &renderer, with: context)
    }
}

public protocol _AsyncHTMLRendering {
    mutating func appendToken(_ token: consuming _HTMLRenderToken) async throws
}

public typealias _BaseHTML = AsyncHTML
#endif