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
    enum html: HTMLTrait.Paired { public static let name = "html" }
    enum head: HTMLTrait.Paired { public static let name = "head" }
    enum title: HTMLTrait.Paired { public static let name = "title" }
    enum body: HTMLTrait.Paired { public static let name = "body" }
    enum h1: HTMLTrait.Paired { public static let name = "h1" }
    enum h2: HTMLTrait.Paired { public static let name = "h2" }
    enum h3: HTMLTrait.Paired { public static let name = "h3" }
    enum h4: HTMLTrait.Paired { public static let name = "h4" }
    enum h5: HTMLTrait.Paired { public static let name = "h5" }
    enum h6: HTMLTrait.Paired { public static let name = "h6" }
    enum p: HTMLTrait.Paired { public static let name = "p" }
    enum br: HTMLTrait.Unpaired { public static let name = "br" }
    enum hr: HTMLTrait.Unpaired { public static let name = "hr" }

    // Formatting
    enum abbr: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "abbr" }
    enum address: HTMLTrait.Paired { public static let name = "address" }
    enum b: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "b" }
    enum bdi: HTMLTrait.Paired { public static let name = "bdi" }
    enum bdo: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "bdo" }
    enum blockquote: HTMLTrait.Paired { public static let name = "blockquote" }
    enum cite: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "cite" }
    enum code: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "code" }
    enum del: HTMLTrait.Paired { public static let name = "del" }
    enum dfn: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "dfn" }
    enum em: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "em" }
    enum i: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "i" }
    enum ins: HTMLTrait.Paired { public static let name = "ins" }
    enum kbd: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "kbd" }
    enum mark: HTMLTrait.Paired { public static let name = "mark" }
    enum meter: HTMLTrait.Paired { public static let name = "meter" }
    enum pre: HTMLTrait.Paired { public static let name = "pre" }
    enum progress: HTMLTrait.Paired { public static let name = "progress" }
    enum q: HTMLTrait.Paired { public static let name = "q" }
    enum rp: HTMLTrait.Paired { public static let name = "rp" }
    enum rt: HTMLTrait.Paired { public static let name = "rt" }
    enum ruby: HTMLTrait.Paired { public static let name = "ruby" }
    enum s: HTMLTrait.Paired { public static let name = "s" }
    enum samp: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "samp" }
    enum small: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "small" }
    enum strong: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "strong" }
    enum sub: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "sub" }
    enum sup: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "sup" }
    enum template: HTMLTrait.Paired { public static let name = "template" }
    enum time: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "time" }
    enum u: HTMLTrait.Paired { public static let name = "u" }
    // enum var_: HTMLTrait.Paired { public static let name = "var" }
    enum wbr: HTMLTrait.Unpaired { public static let name = "wbr" }

    // Forms and Input
    enum form: HTMLTrait.Paired { public static let name = "form" }
    enum input: HTMLTrait.Unpaired { public static let name = "input" }
    enum textarea: HTMLTrait.Paired { public static let name = "textarea" }
    enum button: HTMLTrait.Paired { public static let name = "button" }
    enum select: HTMLTrait.Paired { public static let name = "select" }
    enum optgroup: HTMLTrait.Paired { public static let name = "optgroup" }
    enum option: HTMLTrait.Paired { public static let name = "option" }
    enum label: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "label" }
    enum fieldset: HTMLTrait.Paired { public static let name = "fieldset" }
    enum legend: HTMLTrait.Paired { public static let name = "legend" }
    enum datalist: HTMLTrait.Paired { public static let name = "datalist" }
    enum output: HTMLTrait.Paired { public static let name = "output" }

    // Frames
    enum iframe: HTMLTrait.Paired { public static let name = "iframe" }

    // Images
    enum img: HTMLTrait.Unpaired { public static let name = "img" }
    enum map: HTMLTrait.Paired { public static let name = "map" }
    enum area: HTMLTrait.Unpaired { public static let name = "area" }
    enum canvas: HTMLTrait.Paired { public static let name = "canvas" }
    enum figcaption: HTMLTrait.Paired { public static let name = "figcaption" }
    enum figure: HTMLTrait.Paired { public static let name = "figure" }
    enum picture: HTMLTrait.Paired { public static let name = "picture" }
    enum svg: HTMLTrait.Paired { public static let name = "svg" }

    // Audio / Video
    enum audio: HTMLTrait.Paired { public static let name = "audio" }
    enum source: HTMLTrait.Unpaired { public static let name = "source" }
    enum track: HTMLTrait.Unpaired { public static let name = "track" }
    enum video: HTMLTrait.Paired { public static let name = "video" }

    // Links
    enum a: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "a" }
    enum link: HTMLTrait.Unpaired { public static let name = "link" }
    enum nav: HTMLTrait.Paired { public static let name = "nav" }

    // Lists
    enum menu: HTMLTrait.Paired { public static let name = "menu" }
    enum ul: HTMLTrait.Paired { public static let name = "ul" }
    enum ol: HTMLTrait.Paired { public static let name = "ol" }
    enum li: HTMLTrait.Paired { public static let name = "li" }
    enum dl: HTMLTrait.Paired { public static let name = "dl" }
    enum dt: HTMLTrait.Paired { public static let name = "dt" }
    enum dd: HTMLTrait.Paired { public static let name = "dd" }

    // Tables
    enum table: HTMLTrait.Paired { public static let name = "table" }
    enum caption: HTMLTrait.Paired { public static let name = "caption" }
    enum th: HTMLTrait.Paired { public static let name = "th" }
    enum tr: HTMLTrait.Paired { public static let name = "tr" }
    enum td: HTMLTrait.Paired { public static let name = "td" }
    enum thead: HTMLTrait.Paired { public static let name = "thead" }
    enum tbody: HTMLTrait.Paired { public static let name = "tbody" }
    enum tfoot: HTMLTrait.Paired { public static let name = "tfoot" }
    enum col: HTMLTrait.Unpaired { public static let name = "col" }
    enum colgroup: HTMLTrait.Paired { public static let name = "colgroup" }

    // Styles and Semantics
    enum style: HTMLTrait.Paired { public static let name = "style" }
    enum div: HTMLTrait.Paired { public static let name = "div" }
    enum span: HTMLTrait.Paired, HTMLTrait.RenderedInline { public static let name = "span" }
    enum header: HTMLTrait.Paired { public static let name = "header" }
    enum hgroup: HTMLTrait.Paired { public static let name = "hgroup" }
    enum footer: HTMLTrait.Paired { public static let name = "footer" }
    enum main: HTMLTrait.Paired { public static let name = "main" }
    enum section: HTMLTrait.Paired { public static let name = "section" }
    enum article: HTMLTrait.Paired { public static let name = "article" }
    enum aside: HTMLTrait.Paired { public static let name = "aside" }
    enum details: HTMLTrait.Paired { public static let name = "details" }
    enum dialog: HTMLTrait.Paired { public static let name = "dialog" }
    enum summary: HTMLTrait.Paired { public static let name = "summary" }
    enum data: HTMLTrait.Paired { public static let name = "data" }

    // Meta Info
    enum meta: HTMLTrait.Unpaired { public static let name = "meta" }
    enum base: HTMLTrait.Unpaired { public static let name = "base" }

    // Programming
    enum script: HTMLTrait.Paired { public static let name = "script" }
    enum noscript: HTMLTrait.Paired { public static let name = "noscript" }
    enum embed: HTMLTrait.Unpaired { public static let name = "embed" }
    enum object: HTMLTrait.Paired { public static let name = "object" }
    enum param: HTMLTrait.Unpaired { public static let name = "param" }
}

public extension HTMLTagDefinition where Self: HTMLTrait.RenderedInline {
    static var _rendersInline: Bool { true }
}
