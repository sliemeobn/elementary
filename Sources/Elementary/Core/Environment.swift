#if !hasFeature(Embedded)
/// A property wrapper that reads an environment value from a `TaskLocal`.
///
/// Use `@Environment` to conveniently read a value provided via ``HTML/environment(_:_:)``.
/// Elementary uses task-locals as the underlying storage system for environment variables.
///
/// ```swift
/// enum Values {
///     @TaskLocal static var myNumber = 0
/// }
/// struct MyNumber: HTML {
///     @Environment(Values.$myNumber) var number
///
///     var content: some HTML {
///         p { "\(number)" }
///     }
/// }
/// ```
@propertyWrapper
public struct Environment<T: Sendable>: Sendable {
    enum _Storage {
        case taskLocal(TaskLocal<T>)
        case optionalTaskLocal(TaskLocal<T?>)
    }

    var storage: _Storage

    /// Creates an environment property that reads the value from the given `TaskLocal`.
    /// - Parameter taskLocal: The `TaskLocal` to read the value from.
    public init(_ taskLocal: TaskLocal<T>) {
        storage = .taskLocal(taskLocal)
    }

    /// Creates an environment property that reads the value from the given `TaskLocal`
    /// by force-unwrapping an optional.
    ///
    /// Note: Is the value is `nil` during rendering, a fatal error will be thrown.
    /// - Parameter taskLocal: The `TaskLocal` to read the value from.
    public init(requiring taskLocal: TaskLocal<T?>) {
        storage = .optionalTaskLocal(taskLocal)
    }

    /// The value of the environment property.
    public var wrappedValue: T {
        switch storage {
        case let .taskLocal(taskLocal): return taskLocal.wrappedValue
        case let .optionalTaskLocal(taskLocal):
            guard let value = taskLocal.wrappedValue else {
                fatalError("No value set for \(T.self) in \(taskLocal)")
            }

            return value
        }
    }
}

public extension HTML {
    /// Sets the value of a `TaskLocal` for the duration of rendering the content.
    ///
    /// The value can be accessed using the ``Environment`` property wrapper.
    /// Elementary uses task-locals as the underlying storage system for environment variables.
    ///
    /// ```swift
    /// enum Values {
    ///     @TaskLocal static var myNumber = 0
    /// }
    /// div {
    ///     MyNumber()
    ///         .environment(Values.$myNumber, 15)
    /// }
    /// ```
    func environment<T: Sendable>(_ taskLocal: TaskLocal<T>, _ value: T) -> _ModifiedTaskLocal<T, Self> {
        _ModifiedTaskLocal(wrappedContent: self, taskLocal: taskLocal, value: value)
    }
}

public struct _ModifiedTaskLocal<T: Sendable, Content: HTML>: HTML {
    public typealias Tag = Content.Tag

    var wrappedContent: Content
    var taskLocal: TaskLocal<T>
    var value: T

    @inline(__always)
    public static func _render<Renderer: _HTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) {
        #if compiler(>=6.0)
        // https://github.com/swiftlang/swift/issues/76474
        let context = consume context
        #endif

        html.taskLocal.withValue(html.value) {
            Content._render(html.wrappedContent, into: &renderer, with: context)
        }
    }

    @inline(__always)
    public static func _render<Renderer: _AsyncHTMLRendering>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws {
        #if compiler(>=6.0)
        // https://github.com/swiftlang/swift/issues/76474
        let context = consume context
        #endif

        try await html.taskLocal.withValue(html.value) {
            try await Content._render(html.wrappedContent, into: &renderer, with: context)
        }
    }
}

extension _ModifiedTaskLocal: Sendable where Content: Sendable {}
#endif
