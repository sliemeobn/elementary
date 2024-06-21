public struct HTMLElement<Tag: HTMLTagDefinition, Content: HTML>: HTML where Tag: HTMLTrait.Paired {
    public typealias Tag = Tag
    @HTMLBuilder public var content: Content
    var attributes: AttributeStorage

    public init(@HTMLBuilder content: () -> Content) {
        attributes = .init()
        self.content = content()
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html.attributes.append(context.attributes)
        renderer.appendStartTag(Tag.name, attributes: html.attributes.flattened(), isUnpaired: false, renderType: Tag.renderingType)

        Content._render(html.content, into: &renderer, with: .emptyContext)

        renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
    }
}

public struct HTMLVoidElement<Tag: HTMLTagDefinition>: HTML where Tag: HTMLTrait.Unpaired {
    public typealias Tag = Tag
    var attributes: AttributeStorage

    public init() {
        attributes = .init()
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html.attributes.append(context.attributes)
        renderer.appendStartTag(Tag.name, attributes: html.attributes.flattened(), isUnpaired: true, renderType: Tag.renderingType)
    }
}

public struct HTMLComment: HTML {
    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.comment(html.text))
    }
}

public struct HTMLRaw: HTML {
    public var text: String

    public init(_ text: String) {
        self.text = text
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.raw(html.text))
    }
}

private extension _HTMLRendering {
    // TODO: maybe we could get by without allocating attribute lists and iterate them in somehow
    mutating func appendStartTag(_ tagName: String, attributes: [StoredAttribute], isUnpaired: Bool, renderType: _HTMLRenderToken.RenderingType) {
        appendToken(.startTagOpen(tagName, type: renderType))
        for attribute in attributes {
            appendToken(.attribute(name: attribute.name, value: attribute.value))
        }
        appendToken(.startTagClose(isUnpaired: isUnpaired))
    }
}

extension HTMLTagDefinition {
    static var renderingType: _HTMLRenderToken.RenderingType {
        _rendersInline ? .inline : .block
    }
}
