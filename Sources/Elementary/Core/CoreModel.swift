public protocol Html<Tag> {
    associatedtype Tag: HtmlTagDefinition = Content.Tag
    associatedtype Content: Html = Never

    @HtmlBuilder var content: Content { get }

    @_spi(Rendering)
    static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext)
}

public protocol HtmlTagDefinition {
    static var name: String { get }

    @_spi(Rendering)
    static var _rendersInline: Bool { get }
}

extension Never: HtmlTagDefinition {
    public static var name: String { fatalError("HtmlTag.name was called on Never") }
}

public struct _RenderingContext {
    var attributes: AttributeStorage

    static var emptyContext: Self { Self(attributes: .none) }
}

// TODO: think about this interface... seems not ideal
public enum _HtmlRenderToken {
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

public protocol _HtmlRendering {
    mutating func appendToken(_ token: consuming _HtmlRenderToken)
}

public extension Html {
    static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        Content._render(html.content, into: &renderer, with: context)
    }
}

public extension HtmlTagDefinition {
    @_spi(Rendering)
    static var _rendersInline: Bool { false }
}
