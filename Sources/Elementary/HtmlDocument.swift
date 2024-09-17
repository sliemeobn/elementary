/// A type that represents a full HTML document.
///
/// Provides a simple structure to model top-level HTML types.
/// A default ``HTML/content`` implementation takes your ``title``, ``head``,  ``body`` and
///  (optional) ``lang`` properties and renders them into a full HTML document.
///
/// ```swift
/// struct MyPage: HTMLDocument {
///   var title = "Hello, World!"
///   var lang = "en"
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
    var lang: String { get } // Note: Not an optional to prevent accidental property overloading with type `String` in implementations
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
        .attributes(.lang(lang), when: lang != .undefined)
    }
}

public extension HTMLDocument {
    typealias Language = String
    var lang: Language { .undefined }
}

extension HTMLDocument.Language {
    static let undefined = HTMLDocument.Language()
}
