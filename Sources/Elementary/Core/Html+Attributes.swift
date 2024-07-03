/// An HTML attribute that can be applied to an HTML element of the associated tag.
public struct HTMLAttribute<Tag: HTMLTagDefinition>: Sendable {
    var htmlAttribute: StoredAttribute

    /// The name of the attribute.
    public var name: String { htmlAttribute.name }

    /// The value of the attribute.
    public var value: String? { htmlAttribute.value }
}

/// The action to take when merging an attribute with the same name.
public struct HTMLAttributeMergeAction: Sendable {
    var mergeMode: StoredAttribute.MergeMode

    /// Replaces the value of the existing attribute with the new value.
    public static var replacing: Self { .init(mergeMode: .replaceValue) }

    /// Ignores the new value if the attribute already exists.
    public static var ignoring: Self { .init(mergeMode: .ignoreIfSet) }

    /// Appends the new value to the existing value, separated by the specified string.
    public static func appending(seperatedBy: String) -> Self { .init(mergeMode: .appendValue(seperatedBy)) }
}

public extension HTMLAttribute {
    /// Creates a new HTML attribute with the specified name and value.
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The value of the attribute.
    ///   - action: The merge action to use with a previously attached attribute with the same name.
    init(name: String, value: String?, mergedBy action: HTMLAttributeMergeAction = .replacing) {
        htmlAttribute = .init(name: name, value: value, mergeMode: action.mergeMode)
    }

    /// Changes the default merge action of this attribute.
    /// - Parameter action: The new merge action to use.
    /// - Returns: A modified attribute with the specified merge action.
    consuming func mergedBy(_ action: HTMLAttributeMergeAction) -> HTMLAttribute {
        .init(name: name, value: value, mergedBy: action)
    }
}

public struct _AttributedElement<Content: HTML>: HTML {
    public var content: Content

    var attributes: AttributeStorage

    @_spi(Rendering)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        context.prependAttributes(html.attributes)
        Content._render(html.content, into: &renderer, with: context)
    }

    @_spi(Rendering)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        context.prependAttributes(html.attributes)
        try await Content._render(html.content, into: &renderer, with: context)
    }
}

extension _AttributedElement: Sendable where Content: Sendable {}

public extension HTMLElement {
    /// Creates a new HTML element with the specified attribute and content.
    /// - Parameters:
    ///   - attribute: The attribute to apply to the element.
    ///   - content: The content of the element.
    init(_ attribute: HTMLAttribute<Tag>, @HTMLBuilder content: () -> Content) {
        attributes = .init(attribute)
        self.content = content()
    }

    /// Creates a new HTML element with the specified attributes and content.
    /// - Parameters:
    ///  - attributes: The attributes to apply to the element.
    ///  - content: The content of the element.
    init(_ attributes: HTMLAttribute<Tag>..., @HTMLBuilder content: () -> Content) {
        self.attributes = .init(attributes)
        self.content = content()
    }
}

public extension HTMLVoidElement {
    /// Creates a new HTML void element with the specified attribute.
    /// - Parameter attribute: The attribute to apply to the element.
    init(_ attribute: HTMLAttribute<Tag>) {
        attributes = .init(attribute)
    }

    /// Creates a new HTML void element with the specified attributes.
    /// - Parameter attributes: The attributes to apply to the element.
    init(_ attributes: HTMLAttribute<Tag>...) {
        self.attributes = .init(attributes)
    }
}

public extension HTML where Tag: HTMLTrait.Attributes.Global {
    /// Adds the specified attribute to the element.
    /// - Parameters:
    ///   - attribute: The attribute to add to the element.
    ///   - condition: If set to false, the attribute will not be added.
    /// - Returns: A new element with the specified attribute added.
    func attributes(_ attribute: HTMLAttribute<Tag>, when condition: Bool = true) -> _AttributedElement<Self> {
        if condition {
            return _AttributedElement(content: self, attributes: .init(attribute))
        } else {
            return _AttributedElement(content: self, attributes: .init())
        }
    }

    /// Adds the specified attributes to the element.
    /// - Parameters:
    ///   - attributes: The attributes to add to the element.
    ///   - condition: If set to false, the attributes will not be added.
    /// - Returns: A new element with the specified attributes added.
    func attributes(_ attributes: HTMLAttribute<Tag>..., when condition: Bool = true) -> _AttributedElement<Self> {
        _AttributedElement(content: self, attributes: .init(condition ? attributes : []))
    }
}

private extension _RenderingContext {
    mutating func prependAttributes(_ attributes: consuming AttributeStorage) {
        attributes.append(self.attributes)
        self.attributes = attributes
    }
}
