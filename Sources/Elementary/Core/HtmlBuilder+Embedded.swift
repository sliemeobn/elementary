// since variadic generics are currently not supported in Embedded, here are a few old-school hand-rolled tuples

#if hasFeature(Embedded)
public extension HTMLBuilder {
    static func buildBlock<V0: HTML, V1: HTML>(_ v0: V0, _ v1: V1) -> _HTMLTuple2<V0, V1> {
        return _HTMLTuple2(v0: v0, v1: v1)
    }

    static func buildBlock<V0: HTML, V1: HTML, V2: HTML>(_ v0: V0, _ v1: V1, _ v2: V2) -> _HTMLTuple3<V0, V1, V2> {
        return _HTMLTuple3(v0: v0, v1: v1, v2: v2)
    }

    static func buildBlock<V0: HTML, V1: HTML, V2: HTML, V3: HTML>(_ v0: V0, _ v1: V1, _ v2: V2, _ v3: V3) -> _HTMLTuple4<V0, V1, V2, V3> {
        return _HTMLTuple4(v0: v0, v1: v1, v2: v2, v3: v3)
    }

    static func buildBlock<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML>(_ v0: V0, _ v1: V1, _ v2: V2, _ v3: V3, _ v4: V4) -> _HTMLTuple5<V0, V1, V2, V3, V4> {
        return _HTMLTuple5(v0: v0, v1: v1, v2: v2, v3: v3, v4: v4)
    }
}

public struct _HTMLTuple2<V0: HTML, V1: HTML>: HTML {
    public let v0: V0
    public let v1: V1
}

public struct _HTMLTuple3<V0: HTML, V1: HTML, V2: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
}

public struct _HTMLTuple4<V0: HTML, V1: HTML, V2: HTML, V3: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
    public let v3: V3
}

public struct _HTMLTuple5<V0: HTML, V1: HTML, V2: HTML, V3: HTML, V4: HTML>: HTML {
    public let v0: V0
    public let v1: V1
    public let v2: V2
    public let v3: V3
    public let v4: V4
}
#endif
