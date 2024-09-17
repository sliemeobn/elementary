/// A type that represents HTML content that can be rendered.
///
/// You can create reusable HTML components by conforming to this protocol
/// and implementing the ``content`` property.
///
/// ```swift
/// struct FeatureList: HTML {
///   var features: [String]
///
///   var content: some HTML {
///     ul {
///       for feature in features {
///         li { feature }
///       }
///     }
///   }
/// }
/// ```
public protocol HTML<Tag> {
    /// The HTML tag this component represents, if any.
    ///
    /// The Tag type defines which attributes can be attached to an HTML element.
    /// If an element does not represent a specific HTML tag, the Tag type will
    /// be ``Swift/Never`` and the element cannot be attributed.
    associatedtype Tag: HTMLTagDefinition = Content.Tag

    /// The type of the HTML content this component represents.
    associatedtype Content: HTML = Never

    /// The HTML content of this component.
    @HTMLBuilder var content: Content { get }

    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext)
    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws
}

/// A type that represents an HTML tag.
public protocol HTMLTagDefinition: Sendable {
    /// The name of the HTML tag as it is rendered in an HTML document.
    static var name: String { get }

    @_spi(Rendering)
    static var _rendersInline: Bool { get }
}

extension Never: HTMLTagDefinition {
    public static var name: String { fatalError("HTMLTag.name was called on Never") }
}

public struct _RenderingContext {
    var attributes: AttributeStorage

    static var emptyContext: Self { Self(attributes: .none) }
}

// TODO: think about this interface... seems not ideal
public enum _HTMLRenderToken {
    public enum RenderingType {
        case block
        case inline
    }

    case startTagOpen(String, type: RenderingType)
    case attribute(name: String, value: String?)
    case startTagClose(isUnpaired: Bool = false)
    case endTag(String, type: RenderingType)
    case text(String)
    case raw(String)
    case comment(String)
}

public protocol _HTMLRendering {
    mutating func appendToken(_ token: consuming _HTMLRenderToken)
}

public protocol _AsyncHTMLRendering {
    mutating func appendToken(_ token: consuming _HTMLRenderToken) async throws
}

public extension HTML {
    @_transparent
    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        Content._render(html.content, into: &renderer, with: context)
    }

    @_transparent
    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        try await Content._render(html.content, into: &renderer, with: context)
    }
}

public extension HTMLTagDefinition {
    @_spi(Rendering)
    static var _rendersInline: Bool { false }
}
