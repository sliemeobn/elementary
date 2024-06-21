// https://www.w3schools.com/TAGS/ref_byfunc.asp
// Basic
public typealias html<Content: HTML> = HTMLElement<HTMLTag.html, Content>
public typealias head<Content: HTML> = HTMLElement<HTMLTag.head, Content>
public typealias title<Content: HTML> = HTMLElement<HTMLTag.title, Content>
public typealias body<Content: HTML> = HTMLElement<HTMLTag.body, Content>
public typealias h1<Content: HTML> = HTMLElement<HTMLTag.h1, Content>
public typealias h2<Content: HTML> = HTMLElement<HTMLTag.h2, Content>
public typealias h3<Content: HTML> = HTMLElement<HTMLTag.h3, Content>
public typealias h4<Content: HTML> = HTMLElement<HTMLTag.h4, Content>
public typealias h5<Content: HTML> = HTMLElement<HTMLTag.h5, Content>
public typealias h6<Content: HTML> = HTMLElement<HTMLTag.h6, Content>
public typealias p<Content: HTML> = HTMLElement<HTMLTag.p, Content>
public typealias br = HTMLVoidElement<HTMLTag.br>
public typealias hr = HTMLVoidElement<HTMLTag.hr>

// Formatting
public typealias abbr<Content: HTML> = HTMLElement<HTMLTag.abbr, Content>
public typealias address<Content: HTML> = HTMLElement<HTMLTag.address, Content>
public typealias b<Content: HTML> = HTMLElement<HTMLTag.b, Content>
public typealias bdi<Content: HTML> = HTMLElement<HTMLTag.bdi, Content>
public typealias bdo<Content: HTML> = HTMLElement<HTMLTag.bdo, Content>
public typealias blockquote<Content: HTML> = HTMLElement<HTMLTag.blockquote, Content>
public typealias cite<Content: HTML> = HTMLElement<HTMLTag.cite, Content>
public typealias code<Content: HTML> = HTMLElement<HTMLTag.code, Content>
public typealias del<Content: HTML> = HTMLElement<HTMLTag.del, Content>
public typealias dfn<Content: HTML> = HTMLElement<HTMLTag.dfn, Content>
public typealias em<Content: HTML> = HTMLElement<HTMLTag.em, Content>
public typealias i<Content: HTML> = HTMLElement<HTMLTag.i, Content>
public typealias ins<Content: HTML> = HTMLElement<HTMLTag.ins, Content>
public typealias kbd<Content: HTML> = HTMLElement<HTMLTag.kbd, Content>
public typealias mark<Content: HTML> = HTMLElement<HTMLTag.mark, Content>
public typealias meter<Content: HTML> = HTMLElement<HTMLTag.meter, Content>
public typealias pre<Content: HTML> = HTMLElement<HTMLTag.pre, Content>
public typealias progress<Content: HTML> = HTMLElement<HTMLTag.progress, Content>
public typealias q<Content: HTML> = HTMLElement<HTMLTag.q, Content>
public typealias rp<Content: HTML> = HTMLElement<HTMLTag.rp, Content>
public typealias rt<Content: HTML> = HTMLElement<HTMLTag.rt, Content>
public typealias ruby<Content: HTML> = HTMLElement<HTMLTag.ruby, Content>
public typealias s<Content: HTML> = HTMLElement<HTMLTag.s, Content>
public typealias samp<Content: HTML> = HTMLElement<HTMLTag.samp, Content>
public typealias small<Content: HTML> = HTMLElement<HTMLTag.small, Content>
public typealias strong<Content: HTML> = HTMLElement<HTMLTag.strong, Content>
public typealias sub<Content: HTML> = HTMLElement<HTMLTag.sub, Content>
public typealias sup<Content: HTML> = HTMLElement<HTMLTag.sup, Content>
public typealias template<Content: HTML> = HTMLElement<HTMLTag.template, Content>
public typealias time<Content: HTML> = HTMLElement<HTMLTag.time, Content>
public typealias u<Content: HTML> = HTMLElement<HTMLTag.u, Content>
public typealias wbr = HTMLVoidElement<HTMLTag.wbr>

// Forms and Input
public typealias form<Content: HTML> = HTMLElement<HTMLTag.form, Content>
public typealias input = HTMLVoidElement<HTMLTag.input>
public typealias textarea<Content: HTML> = HTMLElement<HTMLTag.textarea, Content>
public typealias button<Content: HTML> = HTMLElement<HTMLTag.button, Content>
public typealias select<Content: HTML> = HTMLElement<HTMLTag.select, Content>
public typealias optgroup<Content: HTML> = HTMLElement<HTMLTag.optgroup, Content>
public typealias option<Content: HTML> = HTMLElement<HTMLTag.option, Content>
public typealias label<Content: HTML> = HTMLElement<HTMLTag.label, Content>
public typealias fieldset<Content: HTML> = HTMLElement<HTMLTag.fieldset, Content>
public typealias legend<Content: HTML> = HTMLElement<HTMLTag.legend, Content>
public typealias datalist<Content: HTML> = HTMLElement<HTMLTag.datalist, Content>
public typealias output<Content: HTML> = HTMLElement<HTMLTag.output, Content>

// Frames
public typealias iframe<Content: HTML> = HTMLElement<HTMLTag.iframe, Content>

// Images
public typealias img = HTMLVoidElement<HTMLTag.img>
public typealias map<Content: HTML> = HTMLElement<HTMLTag.map, Content>
public typealias area = HTMLVoidElement<HTMLTag.area>
public typealias canvas<Content: HTML> = HTMLElement<HTMLTag.canvas, Content>
public typealias figcaption<Content: HTML> = HTMLElement<HTMLTag.figcaption, Content>
public typealias figure<Content: HTML> = HTMLElement<HTMLTag.figure, Content>
public typealias picture<Content: HTML> = HTMLElement<HTMLTag.picture, Content>
public typealias svg<Content: HTML> = HTMLElement<HTMLTag.svg, Content>

// Audio / Video
public typealias audio<Content: HTML> = HTMLElement<HTMLTag.audio, Content>
public typealias source = HTMLVoidElement<HTMLTag.source>
public typealias track = HTMLVoidElement<HTMLTag.track>
public typealias video<Content: HTML> = HTMLElement<HTMLTag.video, Content>

// Links
public typealias a<Content: HTML> = HTMLElement<HTMLTag.a, Content>
public typealias link = HTMLVoidElement<HTMLTag.link>
public typealias nav<Content: HTML> = HTMLElement<HTMLTag.nav, Content>

// Lists
public typealias menu<Content: HTML> = HTMLElement<HTMLTag.menu, Content>
public typealias ul<Content: HTML> = HTMLElement<HTMLTag.ul, Content>
public typealias ol<Content: HTML> = HTMLElement<HTMLTag.ol, Content>
public typealias li<Content: HTML> = HTMLElement<HTMLTag.li, Content>
public typealias dl<Content: HTML> = HTMLElement<HTMLTag.dl, Content>
public typealias dt<Content: HTML> = HTMLElement<HTMLTag.dt, Content>
public typealias dd<Content: HTML> = HTMLElement<HTMLTag.dd, Content>

// Tables
public typealias table<Content: HTML> = HTMLElement<HTMLTag.table, Content>
public typealias caption<Content: HTML> = HTMLElement<HTMLTag.caption, Content>
public typealias th<Content: HTML> = HTMLElement<HTMLTag.th, Content>
public typealias tr<Content: HTML> = HTMLElement<HTMLTag.tr, Content>
public typealias td<Content: HTML> = HTMLElement<HTMLTag.td, Content>
public typealias thead<Content: HTML> = HTMLElement<HTMLTag.thead, Content>
public typealias tbody<Content: HTML> = HTMLElement<HTMLTag.tbody, Content>
public typealias tfoot<Content: HTML> = HTMLElement<HTMLTag.tfoot, Content>
public typealias col = HTMLVoidElement<HTMLTag.col>
public typealias colgroup<Content: HTML> = HTMLElement<HTMLTag.colgroup, Content>

// Styles and Semantics
public typealias style<Content: HTML> = HTMLElement<HTMLTag.style, Content>
public typealias div<Content: HTML> = HTMLElement<HTMLTag.div, Content>
public typealias span<Content: HTML> = HTMLElement<HTMLTag.span, Content>
public typealias header<Content: HTML> = HTMLElement<HTMLTag.header, Content>
public typealias hgroup<Content: HTML> = HTMLElement<HTMLTag.hgroup, Content>
public typealias footer<Content: HTML> = HTMLElement<HTMLTag.footer, Content>
public typealias main<Content: HTML> = HTMLElement<HTMLTag.main, Content>
public typealias section<Content: HTML> = HTMLElement<HTMLTag.section, Content>
public typealias article<Content: HTML> = HTMLElement<HTMLTag.article, Content>
public typealias aside<Content: HTML> = HTMLElement<HTMLTag.aside, Content>
public typealias details<Content: HTML> = HTMLElement<HTMLTag.details, Content>
public typealias dialog<Content: HTML> = HTMLElement<HTMLTag.dialog, Content>
public typealias summary<Content: HTML> = HTMLElement<HTMLTag.summary, Content>
public typealias data<Content: HTML> = HTMLElement<HTMLTag.data, Content>

// Meta Info
public typealias meta = HTMLVoidElement<HTMLTag.meta>
public typealias base = HTMLVoidElement<HTMLTag.base>

// Programming
public typealias script<Content: HTML> = HTMLElement<HTMLTag.script, Content>
public typealias noscript<Content: HTML> = HTMLElement<HTMLTag.noscript, Content>
public typealias embed = HTMLVoidElement<HTMLTag.embed>
public typealias object<Content: HTML> = HTMLElement<HTMLTag.object, Content>
public typealias param = HTMLVoidElement<HTMLTag.param>
