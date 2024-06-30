public struct HTMLElement<Tag: HTMLTagDefinition, Content: HTML>: HTML where Tag: HTMLTrait.Paired {
    public typealias Tag = Tag
    var attributes: AttributeStorage
    public var content: Content

    public init(@HTMLBuilder content: () -> Content) {
        attributes = .init()
        self.content = content()
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html.attributes.append(context.attributes)
        renderer.appendStartTag(Tag.name, attributes: html.attributes, isUnpaired: false, renderType: Tag.renderingType)
        Content._render(html.content, into: &renderer, with: .emptyContext)
        renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        html.attributes.append(context.attributes)
        try await renderer.appendStartTag(Tag.name, attributes: html.attributes, isUnpaired: false, renderType: Tag.renderingType)
        try await Content._render(html.content, into: &renderer, with: .emptyContext)
        try await renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
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
        renderer.appendStartTag(Tag.name, attributes: html.attributes, isUnpaired: true, renderType: Tag.renderingType)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        html.attributes.append(context.attributes)
        try await renderer.appendStartTag(Tag.name, attributes: html.attributes, isUnpaired: true, renderType: Tag.renderingType)
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

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
        try await renderer.appendToken(.comment(html.text))
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

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
        try await renderer.appendToken(.raw(html.text))
    }
}

private extension _HTMLRendering {
    mutating func appendStartTag(_ tagName: String, attributes: consuming AttributeStorage, isUnpaired: Bool, renderType: _HTMLRenderToken.RenderingType) {
        appendToken(.startTagOpen(tagName, type: renderType))
        for attribute in attributes.flattened() {
            appendToken(.attribute(name: attribute.name, value: attribute.value))
        }
        appendToken(.startTagClose(isUnpaired: isUnpaired))
    }
}

private extension _AsyncHTMLRendering {
    mutating func appendStartTag(_ tagName: String, attributes: consuming AttributeStorage, isUnpaired: Bool, renderType: _HTMLRenderToken.RenderingType) async throws {
        try await appendToken(.startTagOpen(tagName, type: renderType))
        for attribute in attributes.flattened() {
            try await appendToken(.attribute(name: attribute.name, value: attribute.value))
        }
        try await appendToken(.startTagClose(isUnpaired: isUnpaired))
    }
}

private extension HTMLTagDefinition {
    static var renderingType: _HTMLRenderToken.RenderingType {
        _rendersInline ? .inline : .block
    }
}
