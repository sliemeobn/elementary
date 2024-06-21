import Elementary
import XCTest

final class TextRenderingTests: XCTestCase {
    func testRendersText() {
        HTMLAssertEqual(
            h1 { "Hello, World!" },
            "<h1>Hello, World!</h1>"
        )
    }

    func testEscapesText() {
        HTMLAssertEqual(
            h1 { #""Hello" 'World' & <FooBar>"# },
            #"<h1>"Hello" 'World' &amp; &lt;FooBar&gt;</h1>"#
        )
    }

    func testDoesNotEscapeRawText() {
        HTMLAssertEqual(
            h1 { HTMLRaw(#""Hello" 'World' & <FooBar>"#) },
            #"<h1>"Hello" 'World' & <FooBar></h1>"#
        )
    }

    func testRendersListsOfText() {
        HTMLAssertEqual(
            div {
                "Hello, "
                "World!"
            },
            "<div>Hello, World!</div>"
        )
    }

    func testRendersTextWithInlineTags() {
        HTMLAssertEqual(
            div {
                "He"
                b { "llo" }
                br()
                span { "World!" }
            },
            "<div>He<b>llo</b><br><span>World!</span></div>"
        )
    }

    func testRendersComment() {
        HTMLAssertEqual(
            div {
                HTMLComment("Hello !--> World")
            },
            "<div><!--Hello !--&gt; World--></div>"
        )
    }

    func testRendersRaw() {
        HTMLAssertEqual(
            div {
                HTMLRaw(#"<my-tag>"&amp;"</my-tag>"#)
            },
            #"<div><my-tag>"&amp;"</my-tag></div>"#
        )
    }
}
