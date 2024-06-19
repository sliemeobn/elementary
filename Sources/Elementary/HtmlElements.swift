// https://www.w3schools.com/TAGS/ref_byfunc.asp
// Basic
public typealias html<Content: Html> = HtmlElement<HtmlTag.html, Content>
public typealias head<Content: Html> = HtmlElement<HtmlTag.head, Content>
public typealias title<Content: Html> = HtmlElement<HtmlTag.title, Content>
public typealias body<Content: Html> = HtmlElement<HtmlTag.body, Content>
public typealias h1<Content: Html> = HtmlElement<HtmlTag.h1, Content>
public typealias h2<Content: Html> = HtmlElement<HtmlTag.h2, Content>
public typealias h3<Content: Html> = HtmlElement<HtmlTag.h3, Content>
public typealias h4<Content: Html> = HtmlElement<HtmlTag.h4, Content>
public typealias h5<Content: Html> = HtmlElement<HtmlTag.h5, Content>
public typealias h6<Content: Html> = HtmlElement<HtmlTag.h6, Content>
public typealias p<Content: Html> = HtmlElement<HtmlTag.p, Content>
public typealias br = HtmlVoidElement<HtmlTag.br>
public typealias hr = HtmlVoidElement<HtmlTag.hr>

// Formatting
public typealias abbr<Content: Html> = HtmlElement<HtmlTag.abbr, Content>
public typealias address<Content: Html> = HtmlElement<HtmlTag.address, Content>
public typealias b<Content: Html> = HtmlElement<HtmlTag.b, Content>
public typealias bdi<Content: Html> = HtmlElement<HtmlTag.bdi, Content>
public typealias bdo<Content: Html> = HtmlElement<HtmlTag.bdo, Content>
public typealias blockquote<Content: Html> = HtmlElement<HtmlTag.blockquote, Content>
public typealias cite<Content: Html> = HtmlElement<HtmlTag.cite, Content>
public typealias code<Content: Html> = HtmlElement<HtmlTag.code, Content>
public typealias del<Content: Html> = HtmlElement<HtmlTag.del, Content>
public typealias dfn<Content: Html> = HtmlElement<HtmlTag.dfn, Content>
public typealias em<Content: Html> = HtmlElement<HtmlTag.em, Content>
public typealias i<Content: Html> = HtmlElement<HtmlTag.i, Content>
public typealias ins<Content: Html> = HtmlElement<HtmlTag.ins, Content>
public typealias kbd<Content: Html> = HtmlElement<HtmlTag.kbd, Content>
public typealias mark<Content: Html> = HtmlElement<HtmlTag.mark, Content>
public typealias meter<Content: Html> = HtmlElement<HtmlTag.meter, Content>
public typealias pre<Content: Html> = HtmlElement<HtmlTag.pre, Content>
public typealias progress<Content: Html> = HtmlElement<HtmlTag.progress, Content>
public typealias q<Content: Html> = HtmlElement<HtmlTag.q, Content>
public typealias rp<Content: Html> = HtmlElement<HtmlTag.rp, Content>
public typealias rt<Content: Html> = HtmlElement<HtmlTag.rt, Content>
public typealias ruby<Content: Html> = HtmlElement<HtmlTag.ruby, Content>
public typealias s<Content: Html> = HtmlElement<HtmlTag.s, Content>
public typealias samp<Content: Html> = HtmlElement<HtmlTag.samp, Content>
public typealias small<Content: Html> = HtmlElement<HtmlTag.small, Content>
public typealias strong<Content: Html> = HtmlElement<HtmlTag.strong, Content>
public typealias sub<Content: Html> = HtmlElement<HtmlTag.sub, Content>
public typealias sup<Content: Html> = HtmlElement<HtmlTag.sup, Content>
public typealias template<Content: Html> = HtmlElement<HtmlTag.template, Content>
public typealias time<Content: Html> = HtmlElement<HtmlTag.time, Content>
public typealias u<Content: Html> = HtmlElement<HtmlTag.u, Content>
public typealias wbr = HtmlVoidElement<HtmlTag.wbr>

// Forms and Input
public typealias form<Content: Html> = HtmlElement<HtmlTag.form, Content>
public typealias input = HtmlVoidElement<HtmlTag.input>
public typealias textarea<Content: Html> = HtmlElement<HtmlTag.textarea, Content>
public typealias button<Content: Html> = HtmlElement<HtmlTag.button, Content>
public typealias select<Content: Html> = HtmlElement<HtmlTag.select, Content>
public typealias optgroup<Content: Html> = HtmlElement<HtmlTag.optgroup, Content>
public typealias option<Content: Html> = HtmlElement<HtmlTag.option, Content>
public typealias label<Content: Html> = HtmlElement<HtmlTag.label, Content>
public typealias fieldset<Content: Html> = HtmlElement<HtmlTag.fieldset, Content>
public typealias legend<Content: Html> = HtmlElement<HtmlTag.legend, Content>
public typealias datalist<Content: Html> = HtmlElement<HtmlTag.datalist, Content>
public typealias output<Content: Html> = HtmlElement<HtmlTag.output, Content>

// Frames
public typealias iframe<Content: Html> = HtmlElement<HtmlTag.iframe, Content>

// Images
public typealias img = HtmlVoidElement<HtmlTag.img>
public typealias map<Content: Html> = HtmlElement<HtmlTag.map, Content>
public typealias area = HtmlVoidElement<HtmlTag.area>
public typealias canvas<Content: Html> = HtmlElement<HtmlTag.canvas, Content>
public typealias figcaption<Content: Html> = HtmlElement<HtmlTag.figcaption, Content>
public typealias figure<Content: Html> = HtmlElement<HtmlTag.figure, Content>
public typealias picture<Content: Html> = HtmlElement<HtmlTag.picture, Content>
public typealias svg<Content: Html> = HtmlElement<HtmlTag.svg, Content>

// Audio / Video
public typealias audio<Content: Html> = HtmlElement<HtmlTag.audio, Content>
public typealias source = HtmlVoidElement<HtmlTag.source>
public typealias track = HtmlVoidElement<HtmlTag.track>
public typealias video<Content: Html> = HtmlElement<HtmlTag.video, Content>

// Links
public typealias a<Content: Html> = HtmlElement<HtmlTag.a, Content>
public typealias link = HtmlVoidElement<HtmlTag.link>
public typealias nav<Content: Html> = HtmlElement<HtmlTag.nav, Content>

// Lists
public typealias menu<Content: Html> = HtmlElement<HtmlTag.menu, Content>
public typealias ul<Content: Html> = HtmlElement<HtmlTag.ul, Content>
public typealias ol<Content: Html> = HtmlElement<HtmlTag.ol, Content>
public typealias li<Content: Html> = HtmlElement<HtmlTag.li, Content>
public typealias dl<Content: Html> = HtmlElement<HtmlTag.dl, Content>
public typealias dt<Content: Html> = HtmlElement<HtmlTag.dt, Content>
public typealias dd<Content: Html> = HtmlElement<HtmlTag.dd, Content>

// Tables
public typealias table<Content: Html> = HtmlElement<HtmlTag.table, Content>
public typealias caption<Content: Html> = HtmlElement<HtmlTag.caption, Content>
public typealias th<Content: Html> = HtmlElement<HtmlTag.th, Content>
public typealias tr<Content: Html> = HtmlElement<HtmlTag.tr, Content>
public typealias td<Content: Html> = HtmlElement<HtmlTag.td, Content>
public typealias thead<Content: Html> = HtmlElement<HtmlTag.thead, Content>
public typealias tbody<Content: Html> = HtmlElement<HtmlTag.tbody, Content>
public typealias tfoot<Content: Html> = HtmlElement<HtmlTag.tfoot, Content>
public typealias col = HtmlVoidElement<HtmlTag.col>
public typealias colgroup<Content: Html> = HtmlElement<HtmlTag.colgroup, Content>

// Styles and Semantics
public typealias style<Content: Html> = HtmlElement<HtmlTag.style, Content>
public typealias div<Content: Html> = HtmlElement<HtmlTag.div, Content>
public typealias span<Content: Html> = HtmlElement<HtmlTag.span, Content>
public typealias header<Content: Html> = HtmlElement<HtmlTag.header, Content>
public typealias hgroup<Content: Html> = HtmlElement<HtmlTag.hgroup, Content>
public typealias footer<Content: Html> = HtmlElement<HtmlTag.footer, Content>
public typealias main<Content: Html> = HtmlElement<HtmlTag.main, Content>
public typealias section<Content: Html> = HtmlElement<HtmlTag.section, Content>
public typealias article<Content: Html> = HtmlElement<HtmlTag.article, Content>
public typealias aside<Content: Html> = HtmlElement<HtmlTag.aside, Content>
public typealias details<Content: Html> = HtmlElement<HtmlTag.details, Content>
public typealias dialog<Content: Html> = HtmlElement<HtmlTag.dialog, Content>
public typealias summary<Content: Html> = HtmlElement<HtmlTag.summary, Content>
public typealias data<Content: Html> = HtmlElement<HtmlTag.data, Content>

// Meta Info
public typealias meta = HtmlVoidElement<HtmlTag.meta>
public typealias base = HtmlVoidElement<HtmlTag.base>

// Programming
public typealias script<Content: Html> = HtmlElement<HtmlTag.script, Content>
public typealias noscript<Content: Html> = HtmlElement<HtmlTag.noscript, Content>
public typealias embed = HtmlVoidElement<HtmlTag.embed>
public typealias object<Content: Html> = HtmlElement<HtmlTag.object, Content>
public typealias param = HtmlVoidElement<HtmlTag.param>
