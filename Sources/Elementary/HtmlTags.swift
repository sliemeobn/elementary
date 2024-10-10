/// A namespace for HTML tag definitions.
public enum HTMLTag {}

/// A namespace for trait protocols that control the behavior a capabilities of HTML elements.
public enum HTMLTrait {
    /// A namespace for traits that controls which attributes can go with a certain tag.
    public enum Attributes {}
    /// A marker that indicates that an HTML tag is paired.
    public protocol Paired: HTMLTagDefinition, Attributes.Global {}
    /// A marker that indicates that an HTML tag is unpaired.
    public protocol Unpaired: HTMLTagDefinition, Attributes.Global {}
    /// A marker that indicates that an HTML tag should be rendered inline (only controls whitespaces in formatted rendering).
    public protocol RenderedInline {}
}

public extension HTMLTrait.Attributes {
    /// A marker that indicates that an HTML tag can have global attributes.
    ///
    /// Every HTML tag conforms to this.
    protocol Global {}
}

public extension HTMLTag {
    // https://www.w3schools.com/TAGS/ref_byfunc.asp
    // Basic
    enum html: HTMLTrait.Paired { public static let name: StaticString = "html" }
    enum head: HTMLTrait.Paired { public static let name: StaticString = "head" }
    enum title: HTMLTrait.Paired { public static let name: StaticString = "title" }
    enum body: HTMLTrait.Paired { public static let name: StaticString = "body" }
    enum h1: HTMLTrait.Paired { public static let name: StaticString = "h1" }
    enum h2: HTMLTrait.Paired { public static let name: StaticString = "h2" }
    enum h3: HTMLTrait.Paired { public static let name: StaticString = "h3" }
    enum h4: HTMLTrait.Paired { public static let name: StaticString = "h4" }
    enum h5: HTMLTrait.Paired { public static let name: StaticString = "h5" }
    enum h6: HTMLTrait.Paired { public static let name: StaticString = "h6" }
    enum p: HTMLTrait.Paired { public static let name: StaticString = "p" }
    enum br: HTMLTrait.Unpaired { public static let name: StaticString = "br" }
    enum hr: HTMLTrait.Unpaired { public static let name: StaticString = "hr" }

    // Formatting
    enum abbr: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "abbr" }
    enum address: HTMLTrait.Paired { public static let name: StaticString = "address" }
    enum b: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "b" }
    enum bdi: HTMLTrait.Paired { public static let name: StaticString = "bdi" }
    enum bdo: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "bdo" }
    enum blockquote: HTMLTrait.Paired { public static let name: StaticString = "blockquote" }
    enum cite: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "cite" }
    enum code: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "code" }
    enum del: HTMLTrait.Paired { public static let name: StaticString = "del" }
    enum dfn: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "dfn" }
    enum em: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "em" }
    enum i: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "i" }
    enum ins: HTMLTrait.Paired { public static let name: StaticString = "ins" }
    enum kbd: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "kbd" }
    enum mark: HTMLTrait.Paired { public static let name: StaticString = "mark" }
    enum meter: HTMLTrait.Paired { public static let name: StaticString = "meter" }
    enum pre: HTMLTrait.Paired { public static let name: StaticString = "pre" }
    enum progress: HTMLTrait.Paired { public static let name: StaticString = "progress" }
    enum q: HTMLTrait.Paired { public static let name: StaticString = "q" }
    enum rp: HTMLTrait.Paired { public static let name: StaticString = "rp" }
    enum rt: HTMLTrait.Paired { public static let name: StaticString = "rt" }
    enum ruby: HTMLTrait.Paired { public static let name: StaticString = "ruby" }
    enum s: HTMLTrait.Paired { public static let name: StaticString = "s" }
    enum samp: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "samp" }
    enum small: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "small" }
    enum strong: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "strong" }
    enum sub: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "sub" }
    enum sup: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "sup" }
    enum template: HTMLTrait.Paired { public static let name: StaticString = "template" }
    enum time: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "time" }
    enum u: HTMLTrait.Paired { public static let name: StaticString = "u" }
    // enum var_: HTMLTrait.Paired { public static let name: StaticString = "var" }
    enum wbr: HTMLTrait.Unpaired { public static let name: StaticString = "wbr" }

    // Forms and Input
    enum form: HTMLTrait.Paired { public static let name: StaticString = "form" }
    enum input: HTMLTrait.Unpaired { public static let name: StaticString = "input" }
    enum textarea: HTMLTrait.Paired { public static let name: StaticString = "textarea" }
    enum button: HTMLTrait.Paired { public static let name: StaticString = "button" }
    enum select: HTMLTrait.Paired { public static let name: StaticString = "select" }
    enum optgroup: HTMLTrait.Paired { public static let name: StaticString = "optgroup" }
    enum option: HTMLTrait.Paired { public static let name: StaticString = "option" }
    enum label: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "label" }
    enum fieldset: HTMLTrait.Paired { public static let name: StaticString = "fieldset" }
    enum legend: HTMLTrait.Paired { public static let name: StaticString = "legend" }
    enum datalist: HTMLTrait.Paired { public static let name: StaticString = "datalist" }
    enum output: HTMLTrait.Paired { public static let name: StaticString = "output" }

    // Frames
    enum iframe: HTMLTrait.Paired { public static let name: StaticString = "iframe" }

    // Images
    enum img: HTMLTrait.Unpaired { public static let name: StaticString = "img" }
    enum map: HTMLTrait.Paired { public static let name: StaticString = "map" }
    enum area: HTMLTrait.Unpaired { public static let name: StaticString = "area" }
    enum canvas: HTMLTrait.Paired { public static let name: StaticString = "canvas" }
    enum figcaption: HTMLTrait.Paired { public static let name: StaticString = "figcaption" }
    enum figure: HTMLTrait.Paired { public static let name: StaticString = "figure" }
    enum picture: HTMLTrait.Paired { public static let name: StaticString = "picture" }
    enum svg: HTMLTrait.Paired { public static let name: StaticString = "svg" }

    // Audio / Video
    enum audio: HTMLTrait.Paired { public static let name: StaticString = "audio" }
    enum source: HTMLTrait.Unpaired { public static let name: StaticString = "source" }
    enum track: HTMLTrait.Unpaired { public static let name: StaticString = "track" }
    enum video: HTMLTrait.Paired { public static let name: StaticString = "video" }

    // Links
    enum a: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "a" }
    enum link: HTMLTrait.Unpaired { public static let name: StaticString = "link" }
    enum nav: HTMLTrait.Paired { public static let name: StaticString = "nav" }

    // Lists
    enum menu: HTMLTrait.Paired { public static let name: StaticString = "menu" }
    enum ul: HTMLTrait.Paired { public static let name: StaticString = "ul" }
    enum ol: HTMLTrait.Paired { public static let name: StaticString = "ol" }
    enum li: HTMLTrait.Paired { public static let name: StaticString = "li" }
    enum dl: HTMLTrait.Paired { public static let name: StaticString = "dl" }
    enum dt: HTMLTrait.Paired { public static let name: StaticString = "dt" }
    enum dd: HTMLTrait.Paired { public static let name: StaticString = "dd" }

    // Tables
    enum table: HTMLTrait.Paired { public static let name: StaticString = "table" }
    enum caption: HTMLTrait.Paired { public static let name: StaticString = "caption" }
    enum th: HTMLTrait.Paired { public static let name: StaticString = "th" }
    enum tr: HTMLTrait.Paired { public static let name: StaticString = "tr" }
    enum td: HTMLTrait.Paired { public static let name: StaticString = "td" }
    enum thead: HTMLTrait.Paired { public static let name: StaticString = "thead" }
    enum tbody: HTMLTrait.Paired { public static let name: StaticString = "tbody" }
    enum tfoot: HTMLTrait.Paired { public static let name: StaticString = "tfoot" }
    enum col: HTMLTrait.Unpaired { public static let name: StaticString = "col" }
    enum colgroup: HTMLTrait.Paired { public static let name: StaticString = "colgroup" }

    // Styles and Semantics
    enum style: HTMLTrait.Paired { public static let name: StaticString = "style" }
    enum div: HTMLTrait.Paired { public static let name: StaticString = "div" }
    enum span: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name: StaticString = "span" }
    enum header: HTMLTrait.Paired { public static let name: StaticString = "header" }
    enum hgroup: HTMLTrait.Paired { public static let name: StaticString = "hgroup" }
    enum footer: HTMLTrait.Paired { public static let name: StaticString = "footer" }
    enum main: HTMLTrait.Paired { public static let name: StaticString = "main" }
    enum section: HTMLTrait.Paired { public static let name: StaticString = "section" }
    enum article: HTMLTrait.Paired { public static let name: StaticString = "article" }
    enum aside: HTMLTrait.Paired { public static let name: StaticString = "aside" }
    enum details: HTMLTrait.Paired { public static let name: StaticString = "details" }
    enum dialog: HTMLTrait.Paired { public static let name: StaticString = "dialog" }
    enum summary: HTMLTrait.Paired { public static let name: StaticString = "summary" }
    enum data: HTMLTrait.Paired { public static let name: StaticString = "data" }

    // Meta Info
    enum meta: HTMLTrait.Unpaired { public static let name: StaticString = "meta" }
    enum base: HTMLTrait.Unpaired { public static let name: StaticString = "base" }

    // Programming
    enum script: HTMLTrait.Paired { public static let name: StaticString = "script" }
    enum noscript: HTMLTrait.Paired { public static let name: StaticString = "noscript" }
    enum embed: HTMLTrait.Unpaired { public static let name: StaticString = "embed" }
    enum object: HTMLTrait.Paired { public static let name: StaticString = "object" }
    enum param: HTMLTrait.Unpaired { public static let name: StaticString = "param" }
}

public extension HTMLTagDefinition where Self: HTMLTrait.RenderedInline {
    static var _rendersInline: Bool { true }
}
