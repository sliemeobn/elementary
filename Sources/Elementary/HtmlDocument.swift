/// A type that represents a full HTML document.
///
/// Provides a simple structure to model top-level HTML types.
/// A default ``content`` implementation takes your ``title``, ``head`` and ``body``
/// properties and renders them into a full HTML document.
///
/// ```swift
/// struct MyPage: HTMLDocument {
///   var title = "Hello, World!"
///
///   var head: some HTML {
///     meta(.name(.viewport), .content("width=device-width, initial-scale=1.0"))
///   }
///
///   var body: some HTML {
///     h1 { "Hello, World!" }
///     p { "This is a simple HTML document." }
///   }
/// }
/// ```
public protocol HTMLDocument: HTML {
    associatedtype HTMLHead: HTML
    associatedtype HTMLBody: HTML

    var title: String { get }
    @HTMLBuilder var head: HTMLHead { get }
    @HTMLBuilder var body: HTMLBody { get }
}

public extension HTMLDocument {
    @HTMLBuilder var content: some HTML {
        HTMLRaw("<!DOCTYPE html>")
        html {
            Elementary.head {
                Elementary.title { self.title }
                self.head
            }
            Elementary.body { self.body }
        }
    }
}
