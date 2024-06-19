public extension Html {
    consuming func render() -> String {
        var renderer = HtmlTextRenderer()
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }

    consuming func render(into sink: @escaping (String) -> Void) {
        var renderer = HtmlStreamRenderer(sink: sink)
        Self._render(self, into: &renderer, with: .emptyContext)
    }

    // TODO: wrap this behind some config object
    consuming func renderFormatted() -> String {
        var renderer = PrettyHtmlTextRenderer(spaces: 2)
        Self._render(self, into: &renderer, with: .emptyContext)
        return renderer.collect()
    }
}

extension _RenderingContext {
    func assertNoAttributes(_ type: (some Html).Type) {
        assert(attributes.isEmpty, "Attributes are not supported on \(type)")
    }
}
