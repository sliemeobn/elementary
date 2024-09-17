/// A type that represents a full HTML document.
///
/// Provides a simple structure to model top-level HTML types.
/// A default ``HTML/content`` implementation takes your ``title``, ``head``, ``body``, and
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
    var lang: String { get }
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
        .attributes(.lang(lang), when: lang != defaultUndefinedLanguage)
    }
}

// NOTE: The default implementation uses an empty string as the "magic value" for undefined.
// This is to avoid the need for an optional `lang` property on the protocol,
// which would cause confusing issues when adopters provide a property of type `String`.
private let defaultUndefinedLanguage = ""

public extension HTMLDocument {
    /// The default value for the `lang` property is an empty string and will not be rendered in the HTML.
    var lang: String { defaultUndefinedLanguage }
}
