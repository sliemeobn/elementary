// https://www.w3schools.com/TAGS/ref_byfunc.asp
// Basic
public typealias html<Content: _BaseHTML> = HTMLElement<HTMLTag.html, Content>
public typealias head<Content: _BaseHTML> = HTMLElement<HTMLTag.head, Content>
public typealias title<Content: _BaseHTML> = HTMLElement<HTMLTag.title, Content>
public typealias body<Content: _BaseHTML> = HTMLElement<HTMLTag.body, Content>
public typealias h1<Content: _BaseHTML> = HTMLElement<HTMLTag.h1, Content>
public typealias h2<Content: _BaseHTML> = HTMLElement<HTMLTag.h2, Content>
public typealias h3<Content: _BaseHTML> = HTMLElement<HTMLTag.h3, Content>
public typealias h4<Content: _BaseHTML> = HTMLElement<HTMLTag.h4, Content>
public typealias h5<Content: _BaseHTML> = HTMLElement<HTMLTag.h5, Content>
public typealias h6<Content: _BaseHTML> = HTMLElement<HTMLTag.h6, Content>
public typealias p<Content: _BaseHTML> = HTMLElement<HTMLTag.p, Content>
public typealias br = HTMLVoidElement<HTMLTag.br>
public typealias hr = HTMLVoidElement<HTMLTag.hr>

// Formatting
public typealias abbr<Content: _BaseHTML> = HTMLElement<HTMLTag.abbr, Content>
public typealias address<Content: _BaseHTML> = HTMLElement<HTMLTag.address, Content>
public typealias b<Content: _BaseHTML> = HTMLElement<HTMLTag.b, Content>
public typealias bdi<Content: _BaseHTML> = HTMLElement<HTMLTag.bdi, Content>
public typealias bdo<Content: _BaseHTML> = HTMLElement<HTMLTag.bdo, Content>
public typealias blockquote<Content: _BaseHTML> = HTMLElement<HTMLTag.blockquote, Content>
public typealias cite<Content: _BaseHTML> = HTMLElement<HTMLTag.cite, Content>
public typealias code<Content: _BaseHTML> = HTMLElement<HTMLTag.code, Content>
public typealias del<Content: _BaseHTML> = HTMLElement<HTMLTag.del, Content>
public typealias dfn<Content: _BaseHTML> = HTMLElement<HTMLTag.dfn, Content>
public typealias em<Content: _BaseHTML> = HTMLElement<HTMLTag.em, Content>
public typealias i<Content: _BaseHTML> = HTMLElement<HTMLTag.i, Content>
public typealias ins<Content: _BaseHTML> = HTMLElement<HTMLTag.ins, Content>
public typealias kbd<Content: _BaseHTML> = HTMLElement<HTMLTag.kbd, Content>
public typealias mark<Content: _BaseHTML> = HTMLElement<HTMLTag.mark, Content>
public typealias meter<Content: _BaseHTML> = HTMLElement<HTMLTag.meter, Content>
public typealias pre<Content: _BaseHTML> = HTMLElement<HTMLTag.pre, Content>
public typealias progress<Content: _BaseHTML> = HTMLElement<HTMLTag.progress, Content>
public typealias q<Content: _BaseHTML> = HTMLElement<HTMLTag.q, Content>
public typealias rp<Content: _BaseHTML> = HTMLElement<HTMLTag.rp, Content>
public typealias rt<Content: _BaseHTML> = HTMLElement<HTMLTag.rt, Content>
public typealias ruby<Content: _BaseHTML> = HTMLElement<HTMLTag.ruby, Content>
public typealias s<Content: _BaseHTML> = HTMLElement<HTMLTag.s, Content>
public typealias samp<Content: _BaseHTML> = HTMLElement<HTMLTag.samp, Content>
public typealias small<Content: _BaseHTML> = HTMLElement<HTMLTag.small, Content>
public typealias strong<Content: _BaseHTML> = HTMLElement<HTMLTag.strong, Content>
public typealias sub<Content: _BaseHTML> = HTMLElement<HTMLTag.sub, Content>
public typealias sup<Content: _BaseHTML> = HTMLElement<HTMLTag.sup, Content>
public typealias template<Content: _BaseHTML> = HTMLElement<HTMLTag.template, Content>
public typealias time<Content: _BaseHTML> = HTMLElement<HTMLTag.time, Content>
public typealias u<Content: _BaseHTML> = HTMLElement<HTMLTag.u, Content>
public typealias wbr = HTMLVoidElement<HTMLTag.wbr>

// Forms and Input
public typealias form<Content: _BaseHTML> = HTMLElement<HTMLTag.form, Content>
public typealias input = HTMLVoidElement<HTMLTag.input>
public typealias textarea<Content: _BaseHTML> = HTMLElement<HTMLTag.textarea, Content>
public typealias button<Content: _BaseHTML> = HTMLElement<HTMLTag.button, Content>
public typealias select<Content: _BaseHTML> = HTMLElement<HTMLTag.select, Content>
public typealias optgroup<Content: _BaseHTML> = HTMLElement<HTMLTag.optgroup, Content>
public typealias option<Content: _BaseHTML> = HTMLElement<HTMLTag.option, Content>
public typealias label<Content: _BaseHTML> = HTMLElement<HTMLTag.label, Content>
public typealias fieldset<Content: _BaseHTML> = HTMLElement<HTMLTag.fieldset, Content>
public typealias legend<Content: _BaseHTML> = HTMLElement<HTMLTag.legend, Content>
public typealias datalist<Content: _BaseHTML> = HTMLElement<HTMLTag.datalist, Content>
public typealias output<Content: _BaseHTML> = HTMLElement<HTMLTag.output, Content>

// Frames
public typealias iframe<Content: _BaseHTML> = HTMLElement<HTMLTag.iframe, Content>

// Images
public typealias img = HTMLVoidElement<HTMLTag.img>
public typealias map<Content: _BaseHTML> = HTMLElement<HTMLTag.map, Content>
public typealias area = HTMLVoidElement<HTMLTag.area>
public typealias canvas<Content: _BaseHTML> = HTMLElement<HTMLTag.canvas, Content>
public typealias figcaption<Content: _BaseHTML> = HTMLElement<HTMLTag.figcaption, Content>
public typealias figure<Content: _BaseHTML> = HTMLElement<HTMLTag.figure, Content>
public typealias picture<Content: _BaseHTML> = HTMLElement<HTMLTag.picture, Content>
public typealias svg<Content: _BaseHTML> = HTMLElement<HTMLTag.svg, Content>

// Audio / Video
public typealias audio<Content: _BaseHTML> = HTMLElement<HTMLTag.audio, Content>
public typealias source = HTMLVoidElement<HTMLTag.source>
public typealias track = HTMLVoidElement<HTMLTag.track>
public typealias video<Content: _BaseHTML> = HTMLElement<HTMLTag.video, Content>

// Links
public typealias a<Content: _BaseHTML> = HTMLElement<HTMLTag.a, Content>
public typealias link = HTMLVoidElement<HTMLTag.link>
public typealias nav<Content: _BaseHTML> = HTMLElement<HTMLTag.nav, Content>

// Lists
public typealias menu<Content: _BaseHTML> = HTMLElement<HTMLTag.menu, Content>
public typealias ul<Content: _BaseHTML> = HTMLElement<HTMLTag.ul, Content>
public typealias ol<Content: _BaseHTML> = HTMLElement<HTMLTag.ol, Content>
public typealias li<Content: _BaseHTML> = HTMLElement<HTMLTag.li, Content>
public typealias dl<Content: _BaseHTML> = HTMLElement<HTMLTag.dl, Content>
public typealias dt<Content: _BaseHTML> = HTMLElement<HTMLTag.dt, Content>
public typealias dd<Content: _BaseHTML> = HTMLElement<HTMLTag.dd, Content>

// Tables
public typealias table<Content: _BaseHTML> = HTMLElement<HTMLTag.table, Content>
public typealias caption<Content: _BaseHTML> = HTMLElement<HTMLTag.caption, Content>
public typealias th<Content: _BaseHTML> = HTMLElement<HTMLTag.th, Content>
public typealias tr<Content: _BaseHTML> = HTMLElement<HTMLTag.tr, Content>
public typealias td<Content: _BaseHTML> = HTMLElement<HTMLTag.td, Content>
public typealias thead<Content: _BaseHTML> = HTMLElement<HTMLTag.thead, Content>
public typealias tbody<Content: _BaseHTML> = HTMLElement<HTMLTag.tbody, Content>
public typealias tfoot<Content: _BaseHTML> = HTMLElement<HTMLTag.tfoot, Content>
public typealias col = HTMLVoidElement<HTMLTag.col>
public typealias colgroup<Content: _BaseHTML> = HTMLElement<HTMLTag.colgroup, Content>

// Styles and Semantics
public typealias style<Content: _BaseHTML> = HTMLElement<HTMLTag.style, Content>
public typealias div<Content: _BaseHTML> = HTMLElement<HTMLTag.div, Content>
public typealias span<Content: _BaseHTML> = HTMLElement<HTMLTag.span, Content>
public typealias header<Content: _BaseHTML> = HTMLElement<HTMLTag.header, Content>
public typealias hgroup<Content: _BaseHTML> = HTMLElement<HTMLTag.hgroup, Content>
public typealias footer<Content: _BaseHTML> = HTMLElement<HTMLTag.footer, Content>
public typealias main<Content: _BaseHTML> = HTMLElement<HTMLTag.main, Content>
public typealias section<Content: _BaseHTML> = HTMLElement<HTMLTag.section, Content>
public typealias article<Content: _BaseHTML> = HTMLElement<HTMLTag.article, Content>
public typealias aside<Content: _BaseHTML> = HTMLElement<HTMLTag.aside, Content>
public typealias details<Content: _BaseHTML> = HTMLElement<HTMLTag.details, Content>
public typealias dialog<Content: _BaseHTML> = HTMLElement<HTMLTag.dialog, Content>
public typealias summary<Content: _BaseHTML> = HTMLElement<HTMLTag.summary, Content>
public typealias data<Content: _BaseHTML> = HTMLElement<HTMLTag.data, Content>

// Meta Info
public typealias meta = HTMLVoidElement<HTMLTag.meta>
public typealias base = HTMLVoidElement<HTMLTag.base>

// Programming
public typealias script<Content: _BaseHTML> = HTMLElement<HTMLTag.script, Content>
public typealias noscript<Content: _BaseHTML> = HTMLElement<HTMLTag.noscript, Content>
public typealias embed = HTMLVoidElement<HTMLTag.embed>
public typealias object<Content: _BaseHTML> = HTMLElement<HTMLTag.object, Content>
public typealias param = HTMLVoidElement<HTMLTag.param>
