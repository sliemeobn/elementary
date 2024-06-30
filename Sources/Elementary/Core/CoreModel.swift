public protocol HTML<Tag> {
    associatedtype Tag: HTMLTagDefinition = Content.Tag
    associatedtype Content: HTML = Never

    @HTMLBuilder var content: Content { get }

    @_spi(Rendering)
    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext)

    @_spi(Rendering)
    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws
}

public protocol HTMLTagDefinition {
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
    static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        Content._render(html.content, into: &renderer, with: context)
    }

    static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        try await Content._render(html.content, into: &renderer, with: context)
    }
}

public extension HTMLTagDefinition {
    @_spi(Rendering)
    static var _rendersInline: Bool { false }
}
