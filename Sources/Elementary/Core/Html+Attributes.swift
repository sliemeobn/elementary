public struct HTMLAttribute<Tag: HTMLTagDefinition> {
    var htmlAttribute: StoredAttribute

    init(name: String, value: String?, mergeMode: StoredAttribute.MergeMode = .replaceValue) {
        htmlAttribute = .init(name: name, value: value, mergeMode: mergeMode)
    }

    public var name: String { htmlAttribute.name }
    public var value: String? { htmlAttribute.value }
}

public struct _AttributedElement<Content: HTML>: HTML {
    public var content: Content

    var attributes: AttributeStorage

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.prependAttributes(html.attributes)
        Content._render(html.content, into: &renderer, with: context)
    }
}

public extension HTMLElement {
    init(_ attribute: HTMLAttribute<Tag>, @HTMLBuilder content: () -> Content) {
        attributes = .init(attribute)
        self.content = content()
    }

    init(_ attributes: HTMLAttribute<Tag>..., @HTMLBuilder content: () -> Content) {
        self.attributes = .init(attributes)
        self.content = content()
    }
}

public extension HTMLVoidElement {
    init(_ attribute: HTMLAttribute<Tag>) {
        attributes = .init(attribute)
    }

    init(_ attributes: HTMLAttribute<Tag>...) {
        self.attributes = .init(attributes)
    }
}

public extension HTML where Tag: HTMLTrait.Attributes.Global {
    func attributes(_ attribute: HTMLAttribute<Tag>, when condition: Bool = true) -> _AttributedElement<Self> {
        if condition {
            return _AttributedElement(content: self, attributes: .init(attribute))
        } else {
            return _AttributedElement(content: self, attributes: .init())
        }
    }

    func attributes(_ attributes: HTMLAttribute<Tag>..., when condition: Bool = true) -> _AttributedElement<Self> {
        _AttributedElement(content: self, attributes: .init(condition ? attributes : []))
    }
}

extension _RenderingContext {
    mutating func prependAttributes(_ attributes: consuming AttributeStorage) {
        attributes.append(self.attributes)
        self.attributes = attributes
    }
}
