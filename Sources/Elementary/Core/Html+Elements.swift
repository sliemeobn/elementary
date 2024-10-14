/// An HTML element that can contain content.
public struct HTMLElement<Tag: HTMLTagDefinition, Content: HTML>: HTML where Tag: HTMLTrait.Paired {
    /// The type of the HTML tag this element represents.
    public typealias Tag = Tag
    public var _attributes: _AttributeStorage

    // The content of the element.
    public var content: Content

    /// Creates a new HTML element with the specified content.
    /// - Parameter content: The content of the element.
    @inlinable
    public init(@HTMLBuilder content: () -> Content) {
        _attributes = .init()
        self.content = content()
    }

    /// Creates a new HTML element with the specified attribute and content.
    /// - Parameters:
    ///   - attribute: The attribute to apply to the element.
    ///   - content: The content of the element.
    @inlinable
    public init(_ attribute: HTMLAttribute<Tag>, @HTMLBuilder content: () -> Content) {
        _attributes = .init(attribute)
        self.content = content()
    }

    /// Creates a new HTML element with the specified attributes and content.
    /// - Parameters:
    ///  - attributes: The attributes to apply to the element.
    ///  - content: The content of the element.
    @inlinable
    public init(_ attributes: HTMLAttribute<Tag>..., @HTMLBuilder content: () -> Content) {
        _attributes = .init(attributes)
        self.content = content()
    }

    /// Creates a new HTML element with the specified attributes and content.
    /// - Parameters:
    ///  - attributes: The attributes to apply to the element as an array.
    ///  - content: The content of the element.
    @inlinable
    public init(attributes: [HTMLAttribute<Tag>], @HTMLBuilder content: () -> Content) {
        _attributes = .init(attributes)
        self.content = content()
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html._attributes.append(context.attributes)

        renderer.appendToken(.startTag(Tag.name, attributes: html._attributes.flattened(), isUnpaired: false, type: Tag.renderingType))
        Content._render(html.content, into: &renderer, with: .emptyContext)
        renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        html._attributes.append(context.attributes)

        try await renderer.appendToken(.startTag(Tag.name, attributes: html._attributes.flattened(), isUnpaired: false, type: Tag.renderingType))
        try await Content._render(html.content, into: &renderer, with: .emptyContext)
        try await renderer.appendToken(.endTag(Tag.name, type: Tag.renderingType))
    }
}

/// An HTML element that does not contain content.
public struct HTMLVoidElement<Tag: HTMLTagDefinition>: HTML where Tag: HTMLTrait.Unpaired {
    /// The type of the HTML tag this element represents.
    public typealias Tag = Tag
    public var _attributes: _AttributeStorage

    /// Creates a new HTML void element.
    @inlinable
    public init() {
        _attributes = .init()
    }

    /// Creates a new HTML void element with the specified attribute.
    /// - Parameter attribute: The attribute to apply to the element.
    @inlinable
    public init(_ attribute: HTMLAttribute<Tag>) {
        _attributes = .init(attribute)
    }

    /// Creates a new HTML void element with the specified attributes.
    /// - Parameter attributes: The attributes to apply to the element.
    @inlinable
    public init(_ attributes: HTMLAttribute<Tag>...) {
        _attributes = .init(attributes)
    }

    /// Creates a new HTML void element with the specified attributes.
    /// - Parameter attributes: The attributes to apply to the element as an array.
    @inlinable
    public init(attributes: [HTMLAttribute<Tag>]) {
        _attributes = .init(attributes)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        html._attributes.append(context.attributes)
        renderer.appendToken(.startTag(Tag.name, attributes: html._attributes.flattened(), isUnpaired: true, type: Tag.renderingType))
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        html._attributes.append(context.attributes)
        try await renderer.appendToken(.startTag(Tag.name, attributes: html._attributes.flattened(), isUnpaired: true, type: Tag.renderingType))
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

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.comment(html.text))
    }

    @inlinable @inline(__always)
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

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.raw(html.text))
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
        try await renderer.appendToken(.raw(html.text))
    }
}

extension HTMLElement: Sendable where Content: Sendable {}
extension HTMLVoidElement: Sendable {}
extension HTMLComment: Sendable {}
extension HTMLRaw: Sendable {}

extension HTMLTagDefinition {
    @usableFromInline @inline(__always)
    static var renderingType: _HTMLRenderToken.RenderingType {
        _rendersInline ? .inline : .block
    }
}
