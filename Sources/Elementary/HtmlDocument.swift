/// A type that represents a full HTML document.
///
/// Provides a simple structure to model top-level HTML types.
/// A default ``HTML/content`` implementation takes your ``title``, ``head``, ``body``
/// and renders them into a full HTML document.
/// Optionally properties for ``lang`` and ``dir`` can be provided.
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

    /// The title of the HTML document.
    var title: String { get }

    /// The language of the HTML document.
    ///
    /// By default this attribute is not set.
    var lang: String { get }

    /// The text directionality (`ltr`, `rtl`, `auto`) of the HTML document.
    ///
    /// By default this attribute is not set.
    var dir: HTMLAttributeValue.Direction { get }

    @HTMLBuilder var head: HTMLHead { get }
    @HTMLBuilder var body: HTMLBody { get }
}

// NOTE: The default implementation uses an empty string as the "magic value" for undefined.
// This is to avoid the need for an optional `lang` or `dir`` property on the protocol,
// which would cause confusing issues when adopters provide a property of a non-optional type.
private let defaultUndefinedLanguage = ""
private let defaultUndefinedDirection = ""

public extension HTMLDocument {
    /// The default value for the `lang` property is an empty string and will not be rendered in the HTML.
    var lang: String { defaultUndefinedLanguage }
    /// The default value for the `dir` property is an empty string and will not be rendered in the HTML.
    var dir: HTMLAttributeValue.Direction { .init(value: defaultUndefinedDirection) }
}

// NOTE: this is a bit messy after the renaming of var content to var body
public extension HTMLDocument {
    static func _render<Renderer: _HTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) {
        func render<H: HTML>(_ html: H, into renderer: inout some _HTMLRendering, with context: consuming _RenderingContext) {
            H._render(html, into: &renderer, with: context)
        }

        render(html.__body, into: &renderer, with: context)
    }

    static func _render<Renderer: _AsyncHTMLRendering>(
        _ html: consuming Self,
        into renderer: inout Renderer,
        with context: consuming _RenderingContext
    ) async throws {
        func render<H: HTML>(
            _ html: H,
            into renderer: inout some _AsyncHTMLRendering,
            with context: consuming _RenderingContext
        ) async throws {
            try await H._render(html, into: &renderer, with: context)
        }

        try await render(html.__body, into: &renderer, with: context)
    }

    @HTMLBuilder var __body: some HTML {
        HTMLRaw("<!DOCTYPE html>")
        html {
            Elementary.head {
                Elementary.title { self.title }
                self.head
            }
            Elementary.body { self.body }
        }
        .attributes(.lang(lang), when: lang != defaultUndefinedLanguage)
        .attributes(.dir(dir), when: dir.value != defaultUndefinedDirection)
    }
}
