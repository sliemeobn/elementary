/// A result builder for building HTML components.
@resultBuilder public struct HTMLBuilder {
    public static func buildExpression<Content>(_ content: Content) -> Content where Content: HTML {
        content
    }

    public static func buildExpression<Content>(_ content: Content) -> HTMLText where Content: StringProtocol {
        HTMLText(content)
    }

    public static func buildBlock() -> EmptyHTML {
        EmptyHTML()
    }

    public static func buildBlock<Content>(_ content: Content) -> Content where Content: HTML {
        content
    }

    public static func buildBlock<each Content>(_ content: repeat each Content) -> _HTMLTuple < repeat each Content> where repeat each Content: HTML {
        _HTMLTuple(repeat each content)
    }

    public static func buildIf<Content>(_ content: Content?) -> Content? where Content: HTML {
        content
    }

    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(first: TrueContent) -> _HTMLConditional<TrueContent, FalseContent> {
        _HTMLConditional(.trueContent(first))
    }

    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(second: FalseContent) -> _HTMLConditional<TrueContent, FalseContent> {
        _HTMLConditional(.falseContent(second))
    }

    public static func buildArray<Element: HTML>(_ components: [Element]) -> _HTMLArray<Element> {
        return _HTMLArray(components)
    }
}

@_spi(Rendering)
public extension HTML where Content == Never {
    var content: Never {
        fatalError("content cannot be called on \(Self.self)")
    }
}

extension Never: HTML {
    public typealias Tag = Never
    public typealias Content = Never
}

extension Optional: HTML where Wrapped: HTML {
    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html {
        case .none: return
        case let .some(value): Wrapped._render(value, into: &renderer, with: context)
        }
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        switch html {
        case .none: break
        case let .some(value): try await Wrapped._render(value, into: &renderer, with: context)
        }
    }
}

/// A type that represents empty HTML.
public struct EmptyHTML: HTML {
    public init() {}

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
    }
}

/// A type that represents text content in an HTML document.
///
/// The text will be escaped when rendered.
public struct HTMLText: HTML {
    /// The text content.
    public var text: String

    /// Creates a new text content with the specified text.
    public init(_ text: some StringProtocol) {
        self.text = String(text)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.text(html.text))
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
        try await renderer.appendToken(.text(html.text))
    }
}

public struct _HTMLConditional<TrueContent: HTML, FalseContent: HTML>: HTML {
    public enum Value {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    public let value: Value

    init(_ value: Value) {
        self.value = value
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html.value {
        case let .trueContent(content): return TrueContent._render(content, into: &renderer, with: context)
        case let .falseContent(content): return FalseContent._render(content, into: &renderer, with: context)
        }
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        switch html.value {
        case let .trueContent(content): try await TrueContent._render(content, into: &renderer, with: context)
        case let .falseContent(content): try await FalseContent._render(content, into: &renderer, with: context)
        }
    }
}

public extension _HTMLConditional where TrueContent.Tag == FalseContent.Tag {
    typealias Tag = TrueContent.Tag
}

public struct _HTMLTuple<each Child: HTML>: HTML {
    public let value: (repeat each Child)

    init(_ value: repeat each Child) {
        self.value = (repeat each value)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)

        // NOTE: use iteration in swift 6
        func renderElement<Element: HTML>(_ element: Element, _ renderer: inout Renderer) {
            Element._render(element, into: &renderer, with: copy context)
        }
        repeat renderElement(each html.value, &renderer)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)

        // NOTE: use iteration in swift 6
        func renderElement<Element: HTML>(_ element: Element, _ renderer: inout Renderer) async throws {
            try await Element._render(element, into: &renderer, with: copy context)
        }
        repeat try await renderElement(each html.value, &renderer)
    }
}

public struct _HTMLArray<Element: HTML>: HTML {
    public let value: [Element]

    init(_ value: [Element]) {
        self.value = value
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)

        for element in html.value {
            Element._render(element, into: &renderer, with: copy context)
        }
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)

        for element in html.value {
            try await Element._render(element, into: &renderer, with: copy context)
        }
    }
}

extension HTMLText: Sendable {}
extension EmptyHTML: Sendable {}
extension _HTMLConditional.Value: Sendable where TrueContent: Sendable, FalseContent: Sendable {}
extension _HTMLConditional: Sendable where _HTMLConditional.Value: Sendable {}
extension _HTMLTuple: Sendable where repeat each Child: Sendable {}
extension _HTMLArray: Sendable where Element: Sendable {}
