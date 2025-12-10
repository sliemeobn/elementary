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
public protocol HTML<Tag>: AsyncHTML where Self.Body: HTML {
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    )
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

public extension HTML {
    @inlinable
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        Body._render(html.body, into: &renderer, with: context)
    }
}

public extension HTMLTagDefinition {
    @inlinable
    static var _rendersInline: Bool { false }
}
