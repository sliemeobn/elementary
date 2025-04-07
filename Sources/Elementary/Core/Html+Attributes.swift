/// An HTML attribute that can be applied to an HTML element of the associated tag.
public struct HTMLAttribute<Tag: HTMLTagDefinition>: Sendable {
    @usableFromInline
    var htmlAttribute: _StoredAttribute

    /// The name of the attribute.
    public var name: String { htmlAttribute.name }

    /// The value of the attribute.
    public var value: String? { htmlAttribute.value }
}

/// The action to take when merging an attribute with the same name.
public struct HTMLAttributeMergeAction: Sendable {
    @usableFromInline
    var mergeMode: _StoredAttribute.MergeMode

    init(mergeMode: _StoredAttribute.MergeMode) {
        self.mergeMode = mergeMode
    }

    /// Replaces the value of the existing attribute with the new value.
    public static var replacing: Self { .init(mergeMode: .replaceValue) }

    /// Ignores the new value if the attribute already exists.
    public static var ignoring: Self { .init(mergeMode: .ignoreIfSet) }

    /// Appends the new value to the existing value, separated by the specified string.
    @available(*, deprecated, renamed: "appending(separatedBy:)")
    public static func appending(seperatedBy: String) -> Self {
        .init(mergeMode: .appendValue(seperatedBy))
    }

    /// Appends the new value to the existing value, separated by the specified string.
    public static func appending(separatedBy: String) -> Self {
        .init(mergeMode: .appendValue(separatedBy))
    }
}

extension HTMLAttribute {
    /// Creates a new HTML attribute with the specified name and value.
    /// - Parameters:
    ///   - name: The name of the attribute.
    ///   - value: The value of the attribute.
    ///   - action: The merge action to use with a previously attached attribute with the same name.
    @inlinable
    public init(
        name: String, value: String?, mergedBy action: HTMLAttributeMergeAction = .replacing
    ) {
        htmlAttribute = .init(name: name, value: value, mergeMode: action.mergeMode)
    }

    /// Changes the default merge action of this attribute.
    /// - Parameter action: The new merge action to use.
    /// - Returns: A modified attribute with the specified merge action.
    @inlinable
    public consuming func mergedBy(_ action: HTMLAttributeMergeAction) -> HTMLAttribute {
        .init(name: name, value: value, mergedBy: action)
    }
}

public protocol _AttributeStorageModifier {
    func modify(_ attributes: inout _AttributeStorage)
}

extension _ModifiedAttributes: Sendable where Wrapped: Sendable, Modifier: Sendable {}

public struct _ModifiedAttributes<Wrapped: HTML, Modifier: _AttributeStorageModifier>: HTML {
    public typealias Tag = Wrapped.Tag

    public var content: Wrapped
    public var modifier: Modifier

    @usableFromInline
    init(content: Wrapped, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self, into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        html.modifier.modify(&context.attributes)
        Wrapped._render(html.content, into: &renderer, with: context)
    }

    @inlinable @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self, into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        html.modifier.modify(&context.attributes)
        try await Wrapped._render(html.content, into: &renderer, with: context)
    }
}

public struct _PrependedAttributes: _AttributeStorageModifier, Sendable {
    public var attributes: _AttributeStorage

    @usableFromInline
    init(_ attributes: _AttributeStorage) {
        self.attributes = attributes
    }

    @inlinable
    public consuming func modify(_ attributes: inout _AttributeStorage) {
        attributes.prependAttributes(self.attributes)
    }
}

extension _ModifiedAttributes where Modifier == _PrependedAttributes {
    @usableFromInline
    init(content: Wrapped, prepending attributes: _AttributeStorage) {
        self.content = content
        modifier = _PrependedAttributes(attributes)
    }
}

extension HTML where Tag: HTMLTrait.Attributes.Global {
    /// Adds the specified attribute to the element.
    /// - Parameters:
    ///   - attribute: The attribute to add to the element.
    ///   - condition: If set to false, the attribute will not be added.
    /// - Returns: A new element with the specified attribute added.
    @inlinable
    public func attributes(_ attribute: HTMLAttribute<Tag>, when condition: Bool = true)
        -> _ModifiedAttributes<Self, _PrependedAttributes>
    {
        if condition {
            return _ModifiedAttributes(content: self, prepending: .init(attribute))
        } else {
            return _ModifiedAttributes(content: self, prepending: .init())
        }
    }

    /// Adds the specified attributes to the element.
    /// - Parameters:
    ///   - attributes: The attributes to add to the element.
    ///   - condition: If set to false, the attributes will not be added.
    /// - Returns: A new element with the specified attributes added.
    @inlinable
    public func attributes(_ attributes: HTMLAttribute<Tag>..., when condition: Bool = true)
        -> _ModifiedAttributes<Self, _PrependedAttributes>
    {
        _ModifiedAttributes(content: self, prepending: .init(condition ? attributes : []))
    }

    /// Adds the specified attributes to the element.
    /// - Parameters:
    ///   - attributes: The attributes to add to the element as an array.
    ///   - condition: If set to false, the attributes will not be added.
    /// - Returns: A new element with the specified attributes added.
    @inlinable
    public func attributes(contentsOf attributes: [HTMLAttribute<Tag>], when condition: Bool = true)
        -> _ModifiedAttributes<Self, _PrependedAttributes>
    {
        _ModifiedAttributes(content: self, prepending: .init(condition ? attributes : []))
    }
}

extension _AttributeStorage {
    @usableFromInline
    mutating func prependAttributes(_ attributes: consuming _AttributeStorage) {
        attributes.append(self)
        self = attributes
    }
}
