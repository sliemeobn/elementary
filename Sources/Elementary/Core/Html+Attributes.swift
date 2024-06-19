public struct HtmlAttribute<Tag: HtmlTagDefinition> {
    var htmlAttribute: StoredAttribute

    init(name: String, value: String?, mergeMode: StoredAttribute.MergeMode = .replaceValue) {
        htmlAttribute = .init(name: name, value: value, mergeMode: mergeMode)
    }

    public var name: String { htmlAttribute.name }
    public var value: String? { htmlAttribute.value }
}

public struct _AttributedElement<Content: Html>: Html {
    public var content: Content

    var attributes: AttributeStorage

    @_spi(Rendering)
    public static func _render<Renderer: _HtmlRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.prependAttributes(html.attributes)
        Content._render(html.content, into: &renderer, with: context)
    }
}

public extension HtmlElement {
    init(_ attribute: HtmlAttribute<Tag>, @HtmlBuilder content: () -> Content) {
        attributes = .init(attribute)
        self.content = content()
    }

    init(_ attributes: HtmlAttribute<Tag>..., @HtmlBuilder content: () -> Content) {
        self.attributes = .init(attributes)
        self.content = content()
    }
}

public extension HtmlVoidElement {
    init(_ attribute: HtmlAttribute<Tag>) {
        attributes = .init(attribute)
    }

    init(_ attributes: HtmlAttribute<Tag>...) {
        self.attributes = .init(attributes)
    }
}

public extension Html where Tag: HtmlTrait.Attributes.Global {
    func attributes(_ attribute: HtmlAttribute<Tag>, when condition: Bool = true) -> _AttributedElement<Self> {
        if condition {
            return _AttributedElement(content: self, attributes: .init(attribute))
        } else {
            return _AttributedElement(content: self, attributes: .init())
        }
    }

    func attributes(_ attributes: HtmlAttribute<Tag>..., when condition: Bool = true) -> _AttributedElement<Self> {
        _AttributedElement(content: self, attributes: .init(condition ? attributes : []))
    }
}

extension _RenderingContext {
    mutating func prependAttributes(_ attributes: consuming AttributeStorage) {
        attributes.append(self.attributes)
        self.attributes = attributes
    }
}
