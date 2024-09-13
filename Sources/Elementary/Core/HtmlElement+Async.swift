public extension HTMLElement {
    /// Creates a new HTML element with the specified tag and async content.
    ///
    /// The async content closure is automatically wrapped in an ``AsyncContent`` element and can only be rendered in an async context.
    ///
    /// - Parameters:
    ///   - attributes: The attributes to apply to the element.
    ///   - content: The future content of the element.
    init<AwaitedContent: HTML>(_ attributes: HTMLAttribute<Tag>..., @HTMLBuilder content: @escaping @Sendable () async throws -> AwaitedContent)
        where Self.Content == AsyncContent<AwaitedContent>
    {
        self.attributes = .init(attributes)
        self.content = AsyncContent(content: content)
    }

    /// Creates a new HTML element with the specified tag and async content.
    ///
    /// The async content closure is automatically wrapped in an ``AsyncContent``  element and can only be rendered in an async context.
    ///
    /// - Parameters:
    ///   - attributes: The attributes to apply to the element.
    ///   - content: The future content of the element.
    init<AwaitedContent: HTML>(attributes: [HTMLAttribute<Tag>], @HTMLBuilder content: @escaping @Sendable () async throws -> AwaitedContent)
        where Self.Content == AsyncContent<AwaitedContent>
    {
        self.attributes = .init(attributes)
        self.content = AsyncContent(content: content)
    }
}
