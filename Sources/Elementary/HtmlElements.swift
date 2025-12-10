// https://www.w3schools.com/TAGS/ref_byfunc.asp
// Basic
public typealias html<Content: AsyncHTML> = HTMLElement<HTMLTag.html, Content>
public typealias head<Content: AsyncHTML> = HTMLElement<HTMLTag.head, Content>
public typealias title<Content: AsyncHTML> = HTMLElement<HTMLTag.title, Content>
public typealias body<Content: AsyncHTML> = HTMLElement<HTMLTag.body, Content>
public typealias h1<Content: AsyncHTML> = HTMLElement<HTMLTag.h1, Content>
public typealias h2<Content: AsyncHTML> = HTMLElement<HTMLTag.h2, Content>
public typealias h3<Content: AsyncHTML> = HTMLElement<HTMLTag.h3, Content>
public typealias h4<Content: AsyncHTML> = HTMLElement<HTMLTag.h4, Content>
public typealias h5<Content: AsyncHTML> = HTMLElement<HTMLTag.h5, Content>
public typealias h6<Content: AsyncHTML> = HTMLElement<HTMLTag.h6, Content>
public typealias p<Content: AsyncHTML> = HTMLElement<HTMLTag.p, Content>
public typealias br = HTMLVoidElement<HTMLTag.br>
public typealias hr = HTMLVoidElement<HTMLTag.hr>

// Formatting
public typealias abbr<Content: AsyncHTML> = HTMLElement<HTMLTag.abbr, Content>
public typealias address<Content: AsyncHTML> = HTMLElement<HTMLTag.address, Content>
public typealias b<Content: AsyncHTML> = HTMLElement<HTMLTag.b, Content>
public typealias bdi<Content: AsyncHTML> = HTMLElement<HTMLTag.bdi, Content>
public typealias bdo<Content: AsyncHTML> = HTMLElement<HTMLTag.bdo, Content>
public typealias blockquote<Content: AsyncHTML> = HTMLElement<HTMLTag.blockquote, Content>
public typealias cite<Content: AsyncHTML> = HTMLElement<HTMLTag.cite, Content>
public typealias code<Content: AsyncHTML> = HTMLElement<HTMLTag.code, Content>
public typealias del<Content: AsyncHTML> = HTMLElement<HTMLTag.del, Content>
public typealias dfn<Content: AsyncHTML> = HTMLElement<HTMLTag.dfn, Content>
public typealias em<Content: AsyncHTML> = HTMLElement<HTMLTag.em, Content>
public typealias i<Content: AsyncHTML> = HTMLElement<HTMLTag.i, Content>
public typealias ins<Content: AsyncHTML> = HTMLElement<HTMLTag.ins, Content>
public typealias kbd<Content: AsyncHTML> = HTMLElement<HTMLTag.kbd, Content>
public typealias mark<Content: AsyncHTML> = HTMLElement<HTMLTag.mark, Content>
public typealias meter<Content: AsyncHTML> = HTMLElement<HTMLTag.meter, Content>
public typealias pre<Content: AsyncHTML> = HTMLElement<HTMLTag.pre, Content>
public typealias progress<Content: AsyncHTML> = HTMLElement<HTMLTag.progress, Content>
public typealias q<Content: AsyncHTML> = HTMLElement<HTMLTag.q, Content>
public typealias rp<Content: AsyncHTML> = HTMLElement<HTMLTag.rp, Content>
public typealias rt<Content: AsyncHTML> = HTMLElement<HTMLTag.rt, Content>
public typealias ruby<Content: AsyncHTML> = HTMLElement<HTMLTag.ruby, Content>
public typealias s<Content: AsyncHTML> = HTMLElement<HTMLTag.s, Content>
public typealias samp<Content: AsyncHTML> = HTMLElement<HTMLTag.samp, Content>
public typealias small<Content: AsyncHTML> = HTMLElement<HTMLTag.small, Content>
public typealias strong<Content: AsyncHTML> = HTMLElement<HTMLTag.strong, Content>
public typealias sub<Content: AsyncHTML> = HTMLElement<HTMLTag.sub, Content>
public typealias sup<Content: AsyncHTML> = HTMLElement<HTMLTag.sup, Content>
public typealias template<Content: AsyncHTML> = HTMLElement<HTMLTag.template, Content>
public typealias time<Content: AsyncHTML> = HTMLElement<HTMLTag.time, Content>
public typealias u<Content: AsyncHTML> = HTMLElement<HTMLTag.u, Content>
public typealias wbr = HTMLVoidElement<HTMLTag.wbr>

// Forms and Input
public typealias form<Content: AsyncHTML> = HTMLElement<HTMLTag.form, Content>
public typealias input = HTMLVoidElement<HTMLTag.input>
public typealias textarea<Content: AsyncHTML> = HTMLElement<HTMLTag.textarea, Content>
public typealias button<Content: AsyncHTML> = HTMLElement<HTMLTag.button, Content>
public typealias select<Content: AsyncHTML> = HTMLElement<HTMLTag.select, Content>
public typealias optgroup<Content: AsyncHTML> = HTMLElement<HTMLTag.optgroup, Content>
public typealias option<Content: AsyncHTML> = HTMLElement<HTMLTag.option, Content>
public typealias label<Content: AsyncHTML> = HTMLElement<HTMLTag.label, Content>
public typealias fieldset<Content: AsyncHTML> = HTMLElement<HTMLTag.fieldset, Content>
public typealias legend<Content: AsyncHTML> = HTMLElement<HTMLTag.legend, Content>
public typealias datalist<Content: AsyncHTML> = HTMLElement<HTMLTag.datalist, Content>
public typealias output<Content: AsyncHTML> = HTMLElement<HTMLTag.output, Content>

// Frames
public typealias iframe<Content: AsyncHTML> = HTMLElement<HTMLTag.iframe, Content>

// Images
public typealias img = HTMLVoidElement<HTMLTag.img>
public typealias map<Content: AsyncHTML> = HTMLElement<HTMLTag.map, Content>
public typealias area = HTMLVoidElement<HTMLTag.area>
public typealias canvas<Content: AsyncHTML> = HTMLElement<HTMLTag.canvas, Content>
public typealias figcaption<Content: AsyncHTML> = HTMLElement<HTMLTag.figcaption, Content>
public typealias figure<Content: AsyncHTML> = HTMLElement<HTMLTag.figure, Content>
public typealias picture<Content: AsyncHTML> = HTMLElement<HTMLTag.picture, Content>
public typealias svg<Content: AsyncHTML> = HTMLElement<HTMLTag.svg, Content>

// Audio / Video
public typealias audio<Content: AsyncHTML> = HTMLElement<HTMLTag.audio, Content>
public typealias source = HTMLVoidElement<HTMLTag.source>
public typealias track = HTMLVoidElement<HTMLTag.track>
public typealias video<Content: AsyncHTML> = HTMLElement<HTMLTag.video, Content>

// Links
public typealias a<Content: AsyncHTML> = HTMLElement<HTMLTag.a, Content>
public typealias link = HTMLVoidElement<HTMLTag.link>
public typealias nav<Content: AsyncHTML> = HTMLElement<HTMLTag.nav, Content>

// Lists
public typealias menu<Content: AsyncHTML> = HTMLElement<HTMLTag.menu, Content>
public typealias ul<Content: AsyncHTML> = HTMLElement<HTMLTag.ul, Content>
public typealias ol<Content: AsyncHTML> = HTMLElement<HTMLTag.ol, Content>
public typealias li<Content: AsyncHTML> = HTMLElement<HTMLTag.li, Content>
public typealias dl<Content: AsyncHTML> = HTMLElement<HTMLTag.dl, Content>
public typealias dt<Content: AsyncHTML> = HTMLElement<HTMLTag.dt, Content>
public typealias dd<Content: AsyncHTML> = HTMLElement<HTMLTag.dd, Content>

// Tables
public typealias table<Content: AsyncHTML> = HTMLElement<HTMLTag.table, Content>
public typealias caption<Content: AsyncHTML> = HTMLElement<HTMLTag.caption, Content>
public typealias th<Content: AsyncHTML> = HTMLElement<HTMLTag.th, Content>
public typealias tr<Content: AsyncHTML> = HTMLElement<HTMLTag.tr, Content>
public typealias td<Content: AsyncHTML> = HTMLElement<HTMLTag.td, Content>
public typealias thead<Content: AsyncHTML> = HTMLElement<HTMLTag.thead, Content>
public typealias tbody<Content: AsyncHTML> = HTMLElement<HTMLTag.tbody, Content>
public typealias tfoot<Content: AsyncHTML> = HTMLElement<HTMLTag.tfoot, Content>
public typealias col = HTMLVoidElement<HTMLTag.col>
public typealias colgroup<Content: AsyncHTML> = HTMLElement<HTMLTag.colgroup, Content>

// Styles and Semantics
public typealias style<Content: AsyncHTML> = HTMLElement<HTMLTag.style, Content>
public typealias div<Content: AsyncHTML> = HTMLElement<HTMLTag.div, Content>
public typealias span<Content: AsyncHTML> = HTMLElement<HTMLTag.span, Content>
public typealias header<Content: AsyncHTML> = HTMLElement<HTMLTag.header, Content>
public typealias hgroup<Content: AsyncHTML> = HTMLElement<HTMLTag.hgroup, Content>
public typealias footer<Content: AsyncHTML> = HTMLElement<HTMLTag.footer, Content>
public typealias main<Content: AsyncHTML> = HTMLElement<HTMLTag.main, Content>
public typealias section<Content: AsyncHTML> = HTMLElement<HTMLTag.section, Content>
public typealias article<Content: AsyncHTML> = HTMLElement<HTMLTag.article, Content>
public typealias aside<Content: AsyncHTML> = HTMLElement<HTMLTag.aside, Content>
public typealias details<Content: AsyncHTML> = HTMLElement<HTMLTag.details, Content>
public typealias dialog<Content: AsyncHTML> = HTMLElement<HTMLTag.dialog, Content>
public typealias summary<Content: AsyncHTML> = HTMLElement<HTMLTag.summary, Content>
public typealias data<Content: AsyncHTML> = HTMLElement<HTMLTag.data, Content>

// Meta Info
public typealias meta = HTMLVoidElement<HTMLTag.meta>
public typealias base = HTMLVoidElement<HTMLTag.base>

// Programming
public typealias script<Content: AsyncHTML> = HTMLElement<HTMLTag.script, Content>
public typealias noscript<Content: AsyncHTML> = HTMLElement<HTMLTag.noscript, Content>
public typealias embed = HTMLVoidElement<HTMLTag.embed>
public typealias object<Content: AsyncHTML> = HTMLElement<HTMLTag.object, Content>
public typealias param = HTMLVoidElement<HTMLTag.param>
