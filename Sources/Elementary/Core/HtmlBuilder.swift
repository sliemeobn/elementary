@resultBuilder public struct HtmlBuilder {
    public static func buildExpression<Content>(_ content: Content) -> Content where Content: Html {
        content
    }

    public static func buildExpression<Content>(_ content: Content) -> HtmlText<Content> where Content: StringProtocol {
        HtmlText(content)
    }

    public static func buildBlock() -> EmptyHtml {
        EmptyHtml()
    }

    public static func buildBlock<Content>(_ content: Content) -> Content where Content: Html {
        content
    }

    public static func buildBlock<each Content>(_ content: repeat each Content) -> _HtmlTuple < repeat each Content> where repeat each Content: Html {
        _HtmlTuple(repeat each content)
    }

    public static func buildIf<Content>(_ content: Content?) -> Content? where Content: Html {
        content
    }

    public static func buildEither<TrueContent: Html, FalseContent: Html>(first: TrueContent) -> _HtmlConditional<TrueContent, FalseContent> {
        _HtmlConditional(.trueContent(first))
    }

    public static func buildEither<TrueContent: Html, FalseContent: Html>(second: FalseContent) -> _HtmlConditional<TrueContent, FalseContent> {
        _HtmlConditional(.falseContent(second))
    }

    public static func buildArray(_ components: [some Html]) -> some Html {
        return _HtmlArray(components)
    }
}

@_spi(Rendering)
public extension Html where Content == Never {
    var content: Never {
        fatalError("content cannot be called on \(Self.self)")
    }
}

extension Never: Html {
    public typealias Tag = Never
    public typealias Content = Never
}

extension Optional: Html where Wrapped: Html {
    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html {
        case .none: return
        case let .some(value): Wrapped._render(value, into: &renderer, with: context)
        }
    }
}

public struct EmptyHtml: Html {
    public init() {}

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
    }
}

public struct HtmlText<SP: StringProtocol>: Html {
    public var text: SP

    public init(_ text: SP) {
        self.text = text
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.text(String(html.text)))
    }
}

public struct _HtmlConditional<TrueContent: Html, FalseContent: Html>: Html {
    enum Value {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    let value: Value

    init(_ value: Value) {
        self.value = value
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html.value {
        case let .trueContent(content): return TrueContent._render(content, into: &renderer, with: context)
        case let .falseContent(content): return FalseContent._render(content, into: &renderer, with: context)
        }
    }
}

public extension _HtmlConditional where TrueContent.Tag == FalseContent.Tag {
    typealias Tag = TrueContent.Tag
}

public struct _HtmlTuple<each Child: Html>: Html {
    let value: (repeat each Child)

    init(_ value: repeat each Child) {
        self.value = (repeat each value)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)

        func renderElement<Element: Html>(_ element: Element, _ renderer: inout some _HtmlRendering) {
            Element._render(element, into: &renderer, with: copy context)
        }
        repeat renderElement(each html.value, &renderer)
    }
}

public struct _HtmlArray<Element: Html>: Html {
    let value: [Element]

    init(_ value: [Element]) {
        self.value = value
    }

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)

        for element in html.value {
            Element._render(element, into: &renderer, with: copy context)
        }
    }
}
