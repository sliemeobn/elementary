/// An HTML element that can contain content.
public struct HTMLElement<Tag: HTMLTagDefinition, Content: HTML>: HTML where Tag: HTMLTrait.Paired {
    /// The type of the HTML tag this element represents.
    public typealias Tag = Tag
    var attributes: AttributeStorage

    // The content of the element.
    public var content: Content

    /// Creates a new HTML element with the specified content.
    /// - Parameter content: The content of the element.
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

/// An HTML element that does not contain content.
public struct HTMLVoidElement<Tag: HTMLTagDefinition>: HTML where Tag: HTMLTrait.Unpaired {
    /// The type of the HTML tag this element represents.
    public typealias Tag = Tag
    var attributes: AttributeStorage

    /// Creates a new HTML void element.
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

/// A type that represents an HTML comment.
///
/// A comment is rendered as `<!--text-->` and the text will be escaped if necessary.
public struct HTMLComment: HTML {
    /// The text of the comment.
    public var text: String

    /// Creates a new HTML comment with the specified text.
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

/// A type that represents custom raw, untyped HTML.
///
/// The text is rendered as-is without any validation or escaping.
public struct HTMLRaw: HTML {
    /// The raw HTML text.
    public var text: String

    /// Creates a new raw HTML content with the specified text.
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

extension HTMLElement: Sendable where Content: Sendable {}
extension HTMLVoidElement: Sendable {}
extension HTMLComment: Sendable {}
extension HTMLRaw: Sendable {}

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
