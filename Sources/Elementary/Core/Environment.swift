@propertyWrapper
public struct Environment<T: Sendable>: Sendable {
    enum _Storage {
        case taskLocal(TaskLocal<T>)
        case optionalTaskLocal(TaskLocal<T?>)
    }

    var storage: _Storage

    public init(requiring taskLocal: TaskLocal<T?>) {
        storage = .optionalTaskLocal(taskLocal)
    }

    public init(_ taskLocal: TaskLocal<T>) {
        storage = .taskLocal(taskLocal)
    }

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
    func environment<T: Sendable>(_ taskLocal: TaskLocal<T>, _ value: T) -> _ModifiedTaskLocal<T, Self> {
        _ModifiedTaskLocal(wrappedContent: self, taskLocal: taskLocal, value: value)
    }
}

public struct _ModifiedTaskLocal<T: Sendable, Content: HTML>: HTML {
    public typealias Tag = Content.Tag

    var wrappedContent: Content
    var taskLocal: TaskLocal<T>
    var value: T

    @_spi(Rendering)
    public static func _render<Renderer>(_ html: consuming _ModifiedTaskLocal<T, Content>, into renderer: inout Renderer, with context: consuming _RenderingContext) where Renderer: _HTMLRendering {
        html.taskLocal.withValue(html.value) {
            Content._render(html.wrappedContent, into: &renderer, with: context)
        }
    }

    @_spi(Rendering)
    public static func _render<Renderer>(_ html: consuming Self, into renderer: inout Renderer, with context: consuming _RenderingContext) async throws where Renderer: _AsyncHTMLRendering {
        try await html.taskLocal.withValue(html.value) {
            try await Content._render(html.wrappedContent, into: &renderer, with: context)
        }
    }
}

extension _ModifiedTaskLocal: Sendable where Content: Sendable {}
