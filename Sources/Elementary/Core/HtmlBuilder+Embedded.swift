#if hasFeature(Embedded)
    public extension HTMLBuilder {
        static func buildBlock<V0: HTML, V1: HTML>(_ v0: V0, _ v1: V1) -> _ViewTuple2<V0, V1> {
            return _ViewTuple2(v0: v0, v1: v1)
        }
    }

    public struct _ViewTuple2<V0: HTML, V1: HTML>: HTML {
        public let v0: V0
        public let v1: V1
    }
#endif
