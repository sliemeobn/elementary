/// A type that represents HTML content that can be rendered.
///
/// You can create reusable HTML components by conforming to this protocol
/// and implementing the ``content`` property.
///
/// ```swift
/// struct FeatureList: HTML {
///   var features: [String]
///
///   var body: some HTML {
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
    associatedtype Tag: HTMLTagDefinition = Body.Tag

    /// The type of the HTML content this component represents.
    associatedtype Body: HTML

    /// The HTML content of this component.
    @HTMLBuilder var body: Body { get }

    /// The HTML content of this component.
    @HTMLBuilder
    @available(*, deprecated, message: "`var content` is deprecated, use `var body` instead")
    var content: Body { get }

    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    )
    static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws
}

extension HTML {
    @available(*, deprecated, message: "`var content` is deprecated, use `var body` instead")
    public var body: Body {
        // NOTE: sorry for the change
        content
    }

    @available(*, deprecated, message: "Content was renamed, use Body instead")
    public typealias Content = Body

    public var content: Body {
        fatalError("Please make sure to add a `var body` implementation to your HTML type.")
    }
}

/// A type that represents an HTML tag.
public protocol HTMLTagDefinition: Sendable {
    /// The name of the HTML tag as it is rendered in an HTML document.
    static var name: String { get }

    /// Internal property that controls formatted rendering of the element (inline or block).
    ///
    /// A default implementation is provided that returns `false`.
    static var _rendersInline: Bool { get }
}

extension Never: HTMLTagDefinition {
    public static var name: String { fatalError("HTMLTag.name was called on Never") }
}

public struct _RenderingContext {
    @usableFromInline
    var attributes: _AttributeStorage

    public static var emptyContext: Self { Self(attributes: .none) }
}

// TODO: think about this interface... seems not ideal
public enum _HTMLRenderToken {
    public enum RenderingType {
        case block
        case inline
    }

    case startTag(String, attributes: _MergedAttributes, isUnpaired: Bool, type: RenderingType)
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
    @inlinable
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        Body._render(html.body, into: &renderer, with: context)
    }

    @inlinable
    static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        try await Body._render(html.body, into: &renderer, with: context)
    }
}

public extension HTMLTagDefinition {
    @inlinable
    static var _rendersInline: Bool { false }
}
