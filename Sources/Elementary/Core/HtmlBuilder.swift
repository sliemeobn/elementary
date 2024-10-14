/// A result builder for building HTML components.
@resultBuilder public struct HTMLBuilder {
    @inlinable
    public static func buildExpression<Content>(_ content: Content) -> Content where Content: HTML {
        content
    }

    @inlinable
    public static func buildExpression(_ content: String) -> HTMLText {
        HTMLText(content)
    }

    @available(*, deprecated, message: "use buildExpression(_: String) instead")
    public static func buildExpression<Content>(_ content: Content) -> HTMLText where Content: StringProtocol {
        HTMLText(String(content))
    }

    @inlinable
    public static func buildBlock() -> EmptyHTML {
        EmptyHTML()
    }

    @inlinable
    public static func buildBlock<Content>(_ content: Content) -> Content where Content: HTML {
        content
    }

    @inlinable
    public static func buildIf<Content>(_ content: Content?) -> Content? where Content: HTML {
        content
    }

    @inlinable
    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(first: TrueContent) -> _HTMLConditional<TrueContent, FalseContent> {
        _HTMLConditional(.trueContent(first))
    }

    @inlinable
    public static func buildEither<TrueContent: HTML, FalseContent: HTML>(second: FalseContent) -> _HTMLConditional<TrueContent, FalseContent> {
        _HTMLConditional(.falseContent(second))
    }

    @inlinable
    public static func buildArray<Element: HTML>(_ components: [Element]) -> _HTMLArray<Element> {
        return _HTMLArray(components)
    }
}

public extension HTML where Content == Never {
    var content: Never {
        #if hasFeature(Embedded)
        fatalError("content was called on an unsupported type")
        #else
        fatalError("content cannot be called on \(Self.self)")
        #endif
    }
}

extension Never: HTML {
    public typealias Tag = Never
    public typealias Content = Never
}

extension Optional: HTML where Wrapped: HTML {
    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html {
        case .none: return
        case let .some(value): Wrapped._render(value, into: &renderer, with: context)
        }
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        switch html {
        case .none: break
        case let .some(value): try await Wrapped._render(value, into: &renderer, with: context)
        }
    }
}

/// A type that represents empty HTML.
public struct EmptyHTML: HTML, Sendable {
    public init() {}

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
    }
}

/// A type that represents text content in an HTML document.
///
/// The text will be escaped when rendered.
public struct HTMLText: HTML, Sendable {
    /// The text content.
    public var text: String

    /// Creates a new text content with the specified text.
    @available(*, deprecated, message: "use init(_: String) instead")
    public init(_ text: some StringProtocol) {
        self.text = String(text)
    }

    /// Creates a new text content with the specified text.
    @inlinable
    public init(_ text: String) {
        self.text = text
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)
        renderer.appendToken(.text(html.text))
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)
        try await renderer.appendToken(.text(html.text))
    }
}

extension _HTMLConditional.Value: Sendable where TrueContent: Sendable, FalseContent: Sendable {}
extension _HTMLConditional: Sendable where _HTMLConditional.Value: Sendable {}

public struct _HTMLConditional<TrueContent: HTML, FalseContent: HTML>: HTML {
    public enum Value {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    public let value: Value

    @inlinable
    public init(_ value: Value) {
        self.value = value
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        switch html.value {
        case let .trueContent(content): return TrueContent._render(content, into: &renderer, with: context)
        case let .falseContent(content): return FalseContent._render(content, into: &renderer, with: context)
        }
    }

    @inlinable @inline(__always)
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

extension _HTMLArray: Sendable where Element: Sendable {}

public struct _HTMLArray<Element: HTML>: HTML {
    public let value: [Element]

    @inlinable
    public init(_ value: [Element]) {
        self.value = value
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.assertNoAttributes(self)

        for element in html.value {
            Element._render(element, into: &renderer, with: copy context)
        }
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.assertNoAttributes(self)

        for element in html.value {
            try await Element._render(element, into: &renderer, with: copy context)
        }
    }
}
