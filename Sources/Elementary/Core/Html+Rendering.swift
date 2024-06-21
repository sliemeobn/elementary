public extension HTML {
    consuming func render() -> String {
        var renderer = HTMLTextRenderer()
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }

    consuming func render(into writer: @escaping (String) -> Void) {
        var renderer = HTMLStreamRenderer(writer: writer)
        Self._render(self, into: &renderer, with: .emptyContext)
    }

    // TODO: wrap this behind some config object
    consuming func renderFormatted() -> String {
        var renderer = PrettyHTMLTextRenderer(spaces: 2)
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }
}

extension _RenderingContext {
    func assertNoAttributes(_ type: (some HTML).Type) {
        assert(attributes.isEmpty, "Attributes are not supported on \(type)")
    }
}
