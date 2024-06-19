public enum HtmlTag {}

public enum HtmlTrait {
    public enum Attributes {}
    public protocol Paired: HtmlTagDefinition, Attributes.Global {}
    public protocol Unpaired: HtmlTagDefinition, Attributes.Global {}
    public protocol RenderedInline {}
}

public extension HtmlTrait.Attributes {
    protocol Global {}
}

public extension HtmlTag {
    // https://www.w3schools.com/TAGS/ref_byfunc.asp
    // Basic
    enum html: HtmlTrait.Paired { public static let name = "html" }
    enum head: HtmlTrait.Paired { public static let name = "head" }
    enum title: HtmlTrait.Paired { public static let name = "title" }
    enum body: HtmlTrait.Paired { public static let name = "body" }
    enum h1: HtmlTrait.Paired { public static let name = "h1" }
    enum h2: HtmlTrait.Paired { public static let name = "h2" }
    enum h3: HtmlTrait.Paired { public static let name = "h3" }
    enum h4: HtmlTrait.Paired { public static let name = "h4" }
    enum h5: HtmlTrait.Paired { public static let name = "h5" }
    enum h6: HtmlTrait.Paired { public static let name = "h6" }
    enum p: HtmlTrait.Paired { public static let name = "p" }
    enum br: HtmlTrait.Unpaired { public static let name = "br" }
    enum hr: HtmlTrait.Unpaired { public static let name = "hr" }

    // Formatting
    enum abbr: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "abbr" }
    enum address: HtmlTrait.Paired { public static let name = "address" }
    enum b: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "b" }
    enum bdi: HtmlTrait.Paired { public static let name = "bdi" }
    enum bdo: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "bdo" }
    enum blockquote: HtmlTrait.Paired { public static let name = "blockquote" }
    enum cite: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "cite" }
    enum code: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "code" }
    enum del: HtmlTrait.Paired { public static let name = "del" }
    enum dfn: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "dfn" }
    enum em: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "em" }
    enum i: HtmlTrait.Paired { public static let name = "i" }
    enum ins: HtmlTrait.Paired { public static let name = "ins" }
    enum kbd: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "kbd" }
    enum mark: HtmlTrait.Paired { public static let name = "mark" }
    enum meter: HtmlTrait.Paired { public static let name = "meter" }
    enum pre: HtmlTrait.Paired { public static let name = "pre" }
    enum progress: HtmlTrait.Paired { public static let name = "progress" }
    enum q: HtmlTrait.Paired { public static let name = "q" }
    enum rp: HtmlTrait.Paired { public static let name = "rp" }
    enum rt: HtmlTrait.Paired { public static let name = "rt" }
    enum ruby: HtmlTrait.Paired { public static let name = "ruby" }
    enum s: HtmlTrait.Paired { public static let name = "s" }
    enum samp: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "samp" }
    enum small: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "small" }
    enum strong: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "strong" }
    enum sub: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "sub" }
    enum sup: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "sup" }
    enum template: HtmlTrait.Paired { public static let name = "template" }
    enum time: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "time" }
    enum u: HtmlTrait.Paired { public static let name = "u" }
    // enum var_: HtmlTrait.Paired { public static let name = "var" }
    enum wbr: HtmlTrait.Unpaired { public static let name = "wbr" }

    // Forms and Input
    enum form: HtmlTrait.Paired { public static let name = "form" }
    enum input: HtmlTrait.Unpaired { public static let name = "input" }
    enum textarea: HtmlTrait.Paired { public static let name = "textarea" }
    enum button: HtmlTrait.Paired { public static let name = "button" }
    enum select: HtmlTrait.Paired { public static let name = "select" }
    enum optgroup: HtmlTrait.Paired { public static let name = "optgroup" }
    enum option: HtmlTrait.Paired { public static let name = "option" }
    enum label: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "label" }
    enum fieldset: HtmlTrait.Paired { public static let name = "fieldset" }
    enum legend: HtmlTrait.Paired { public static let name = "legend" }
    enum datalist: HtmlTrait.Paired { public static let name = "datalist" }
    enum output: HtmlTrait.Paired { public static let name = "output" }

    // Frames
    enum iframe: HtmlTrait.Paired { public static let name = "iframe" }

    // Images
    enum img: HtmlTrait.Unpaired { public static let name = "img" }
    enum map: HtmlTrait.Paired { public static let name = "map" }
    enum area: HtmlTrait.Unpaired { public static let name = "area" }
    enum canvas: HtmlTrait.Paired { public static let name = "canvas" }
    enum figcaption: HtmlTrait.Paired { public static let name = "figcaption" }
    enum figure: HtmlTrait.Paired { public static let name = "figure" }
    enum picture: HtmlTrait.Paired { public static let name = "picture" }
    enum svg: HtmlTrait.Paired { public static let name = "svg" }

    // Audio / Video
    enum audio: HtmlTrait.Paired { public static let name = "audio" }
    enum source: HtmlTrait.Unpaired { public static let name = "source" }
    enum track: HtmlTrait.Unpaired { public static let name = "track" }
    enum video: HtmlTrait.Paired { public static let name = "video" }

    // Links
    enum a: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "a" }
    enum link: HtmlTrait.Unpaired { public static let name = "link" }
    enum nav: HtmlTrait.Paired { public static let name = "nav" }

    // Lists
    enum menu: HtmlTrait.Paired { public static let name = "menu" }
    enum ul: HtmlTrait.Paired { public static let name = "ul" }
    enum ol: HtmlTrait.Paired { public static let name = "ol" }
    enum li: HtmlTrait.Paired { public static let name = "li" }
    enum dl: HtmlTrait.Paired { public static let name = "dl" }
    enum dt: HtmlTrait.Paired { public static let name = "dt" }
    enum dd: HtmlTrait.Paired { public static let name = "dd" }

    // Tables
    enum table: HtmlTrait.Paired { public static let name = "table" }
    enum caption: HtmlTrait.Paired { public static let name = "caption" }
    enum th: HtmlTrait.Paired { public static let name = "th" }
    enum tr: HtmlTrait.Paired { public static let name = "tr" }
    enum td: HtmlTrait.Paired { public static let name = "td" }
    enum thead: HtmlTrait.Paired { public static let name = "thead" }
    enum tbody: HtmlTrait.Paired { public static let name = "tbody" }
    enum tfoot: HtmlTrait.Paired { public static let name = "tfoot" }
    enum col: HtmlTrait.Unpaired { public static let name = "col" }
    enum colgroup: HtmlTrait.Paired { public static let name = "colgroup" }

    // Styles and Semantics
    enum style: HtmlTrait.Paired { public static let name = "style" }
    enum div: HtmlTrait.Paired { public static let name = "div" }
    enum span: HtmlTrait.Paired, HtmlTrait.RenderedInline { public static let name = "span" }
    enum header: HtmlTrait.Paired { public static let name = "header" }
    enum hgroup: HtmlTrait.Paired { public static let name = "hgroup" }
    enum footer: HtmlTrait.Paired { public static let name = "footer" }
    enum main: HtmlTrait.Paired { public static let name = "main" }
    enum section: HtmlTrait.Paired { public static let name = "section" }
    enum article: HtmlTrait.Paired { public static let name = "article" }
    enum aside: HtmlTrait.Paired { public static let name = "aside" }
    enum details: HtmlTrait.Paired { public static let name = "details" }
    enum dialog: HtmlTrait.Paired { public static let name = "dialog" }
    enum summary: HtmlTrait.Paired { public static let name = "summary" }
    enum data: HtmlTrait.Paired { public static let name = "data" }

    // Meta Info
    enum meta: HtmlTrait.Unpaired { public static let name = "meta" }
    enum base: HtmlTrait.Unpaired { public static let name = "base" }

    // Programming
    enum script: HtmlTrait.Paired { public static let name = "script" }
    enum noscript: HtmlTrait.Paired { public static let name = "noscript" }
    enum embed: HtmlTrait.Unpaired { public static let name = "embed" }
    enum object: HtmlTrait.Paired { public static let name = "object" }
    enum param: HtmlTrait.Unpaired { public static let name = "param" }
}

public extension HtmlTagDefinition where Self: HtmlTrait.RenderedInline {
    static var _rendersInline: Bool { true }
}
