public struct HtmlElement<Tag: HtmlTagDefinition, Content: Html>: Html where Tag: HtmlTrait.Paired {
    public typealias Tag = Tag
    @HtmlBuilder public var content: Content
    var attributes: AttributeStorage

    public init(@HtmlBuilder content: () -> Content) {
        attributes = .init()
        self.content = content()
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html.attributes.append(context.attributes)
        renderer.appendStartTag(Tag.name, attributes: html.attributes.flattened(), isUnpaired: false, renderType: Tag.renderingType)

        Content._render(html.content, into: &renderer, with: .emptyContext)

        renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
    }
}

public struct HtmlVoidElement<Tag: HtmlTagDefinition>: Html where Tag: HtmlTrait.Unpaired {
    public typealias Tag = Tag
    var attributes: AttributeStorage

    public init() {
        attributes = .init()
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html.attributes.append(context.attributes)
        renderer.appendStartTag(Tag.name, attributes: html.attributes.flattened(), isUnpaired: true, renderType: Tag.renderingType)
    }
}

public struct HtmlComment: Html {
    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.comment(html.text))
    }
}

public struct HtmlRaw: Html {
    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.raw(html.text))
    }
}

private extension _HtmlRendering {
    // TODO: maybe we could get by without allocating attribute lists and iterate them in somehow
    mutating func appendStartTag(_ tagName: String, attributes: [StoredAttribute], isUnpaired: Bool, renderType: _HtmlRenderToken.RenderingType) {
        appendToken(.startTagOpen(tagName, type: renderType))
        for attribute in attributes {
            appendToken(.attribute(name: attribute.name, value: attribute.value))
        }
        appendToken(.startTagClose(isUnpaired: isUnpaired))
    }
}

extension HtmlTagDefinition {
    static var renderingType: _HtmlRenderToken.RenderingType {
        _rendersInline ? .inline : .block
    }
}
