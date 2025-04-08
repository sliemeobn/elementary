// hand-rolled tuples types for embedded support (variadic generics are not supported in Embedded ATM)
// unfortunately variadic generics perform significantly worse than the hand-rolled tuples,
// so we can just use them for normal HTML rendering as well

public extension HTMLBuilder {
    @inlinable
    static func buildBlock<V0: HTML, V1: HTML>(_ v0: V0, _ v1: V1) -> _HTMLTuple2<V0, V1> {
        _HTMLTuple2(v0: v0, v1: v1)
    }

    @inlinable
    static func buildBlock<V0: HTML, V1: HTML, V2: HTML>(_ v0: V0, _ v1: V1, _ v2: V2) -> _HTMLTuple3<V0, V1, V2> {
        _HTMLTuple3(v0: v0, v1: v1, v2: v2)
    }

    @inlinable
    static func buildBlock<V0: HTML, V1: HTML, V2: HTML, V3: HTML>(_ v0: V0, _ v1: V1, _ v2: V2, _ v3: V3) -> _HTMLTuple4<V0, V1, V2, V3> {
        _HTMLTuple4(v0: v0, v1: v1, v2: v2, v3: v3)
    }

    @inlinable
    static func buildBlock<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML>(
        _ v0: V0,
        _ v1: V1,
        _ v2: V2,
        _ v3: V3,
        _ v4: V4
    ) -> _HTMLTuple5<V0, V1, V2, V3, V4> {
        _HTMLTuple5(v0: v0, v1: v1, v2: v2, v3: v3, v4: v4)
    }

    @inlinable
    static func buildBlock<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML, V5: HTML>(
        _ v0: V0,
        _ v1: V1,
        _ v2: V2,
        _ v3: V3,
        _ v4: V4,
        _ v5: V5
    ) -> _HTMLTuple6<V0, V1, V2, V3, V4, V5> {
        _HTMLTuple6(v0: v0, v1: v1, v2: v2, v3: v3, v4: v4, v5: v5)
    }

    // variadic generics currently not supported in embedded
    #if !hasFeature(Embedded)
    @inlinable
    static func buildBlock<each Content>(_ content: repeat each Content) -> _HTMLTuple<repeat each Content>
    where repeat each Content: HTML {
        _HTMLTuple(repeat each content)
    }
    #endif
}

extension _HTMLTuple2: Sendable where V0: Sendable, V1: Sendable {}
public struct _HTMLTuple2<V0: HTML, V1: HTML>: HTML {
    public let v0: V0
    public let v1: V1

    @inlinable
    public init(v0: V0, v1: V1) {
        self.v0 = v0
        self.v1 = v1
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        V0._render(html.v0, into: &renderer, with: copy context)
        V1._render(html.v1, into: &renderer, with: copy context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        try await V0._render(html.v0, into: &renderer, with: copy context)
        try await V1._render(html.v1, into: &renderer, with: copy context)
    }
}

extension _HTMLTuple3: Sendable where V0: Sendable, V1: Sendable, V2: Sendable {}
public struct _HTMLTuple3<V0: HTML, V1: HTML, V2: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2

    @inlinable
    public init(v0: V0, v1: V1, v2: V2) {
        self.v0 = v0
        self.v1 = v1
        self.v2 = v2
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        V0._render(html.v0, into: &renderer, with: copy context)
        V1._render(html.v1, into: &renderer, with: copy context)
        V2._render(html.v2, into: &renderer, with: copy context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        try await V0._render(html.v0, into: &renderer, with: copy context)
        try await V1._render(html.v1, into: &renderer, with: copy context)
        try await V2._render(html.v2, into: &renderer, with: copy context)
    }
}

extension _HTMLTuple4: Sendable where V0: Sendable, V1: Sendable, V2: Sendable, V3: Sendable {}
public struct _HTMLTuple4<V0: HTML, V1: HTML, V2: HTML, V3: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
    public let v3: V3

    @inlinable
    public init(v0: V0, v1: V1, v2: V2, v3: V3) {
        self.v0 = v0
        self.v1 = v1
        self.v2 = v2
        self.v3 = v3
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        V0._render(html.v0, into: &renderer, with: copy context)
        V1._render(html.v1, into: &renderer, with: copy context)
        V2._render(html.v2, into: &renderer, with: copy context)
        V3._render(html.v3, into: &renderer, with: copy context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        try await V0._render(html.v0, into: &renderer, with: copy context)
        try await V1._render(html.v1, into: &renderer, with: copy context)
        try await V2._render(html.v2, into: &renderer, with: copy context)
        try await V3._render(html.v3, into: &renderer, with: copy context)
    }
}

extension _HTMLTuple5: Sendable where V0: Sendable, V1: Sendable, V2: Sendable, V3: Sendable, V4: Sendable {}
public struct _HTMLTuple5<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
    public let v3: V3
    public let v4: V4

    @inlinable
    public init(v0: V0, v1: V1, v2: V2, v3: V3, v4: V4) {
        self.v0 = v0
        self.v1 = v1
        self.v2 = v2
        self.v3 = v3
        self.v4 = v4
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        V0._render(html.v0, into: &renderer, with: copy context)
        V1._render(html.v1, into: &renderer, with: copy context)
        V2._render(html.v2, into: &renderer, with: copy context)
        V3._render(html.v3, into: &renderer, with: copy context)
        V4._render(html.v4, into: &renderer, with: copy context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        try await V0._render(html.v0, into: &renderer, with: copy context)
        try await V1._render(html.v1, into: &renderer, with: copy context)
        try await V2._render(html.v2, into: &renderer, with: copy context)
        try await V3._render(html.v3, into: &renderer, with: copy context)
        try await V4._render(html.v4, into: &renderer, with: copy context)
    }
}

extension _HTMLTuple6: Sendable where V0: Sendable, V1: Sendable, V2: Sendable, V3: Sendable, V4: Sendable, V5: Sendable {}
public struct _HTMLTuple6<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML, V5: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
    public let v3: V3
    public let v4: V4
    public let v5: V5

    @inlinable
    public init(v0: V0, v1: V1, v2: V2, v3: V3, v4: V4, v5: V5) {
        self.v0 = v0
        self.v1 = v1
        self.v2 = v2
        self.v3 = v3
        self.v4 = v4
        self.v5 = v5
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        V0._render(html.v0, into: &renderer, with: copy context)
        V1._render(html.v1, into: &renderer, with: copy context)
        V2._render(html.v2, into: &renderer, with: copy context)
        V3._render(html.v3, into: &renderer, with: copy context)
        V4._render(html.v4, into: &renderer, with: copy context)
        V5._render(html.v5, into: &renderer, with: copy context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        try await V0._render(html.v0, into: &renderer, with: copy context)
        try await V1._render(html.v1, into: &renderer, with: copy context)
        try await V2._render(html.v2, into: &renderer, with: copy context)
        try await V3._render(html.v3, into: &renderer, with: copy context)
        try await V4._render(html.v4, into: &renderer, with: copy context)
        try await V5._render(html.v5, into: &renderer, with: copy context)
    }
}

// variadic generics currently not supported in embedded
#if !hasFeature(Embedded)
extension _HTMLTuple: Sendable where repeat each Child: Sendable {}

public struct _HTMLTuple<each Child: HTML>: HTML {
    public let value: (repeat each Child)

    @inlinable
    public init(_ value: repeat each Child) {
        self.value = (repeat each value)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        context.assertNoAttributes(self)

        // NOTE: use iteration in swift 6
        func renderElement<Element: HTML>(_ element: Element, _ renderer: inout Renderer) {
            Element._render(element, into: &renderer, with: copy context)
        }
        repeat renderElement(each html.value, &renderer)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        context.assertNoAttributes(self)

        // NOTE: use iteration in swift 6
        func renderElement<Element: HTML>(_ element: Element, _ renderer: inout Renderer) async throws {
            try await Element._render(element, into: &renderer, with: copy context)
        }
        repeat try await renderElement(each html.value, &renderer)
    }
}
#endif
