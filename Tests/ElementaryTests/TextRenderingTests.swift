import Elementary
import XCTest

final class TextRenderingTests: XCTestCase {
    func testRendersText() {
        HtmlAssertEqual(
            h1 { "Hello, World!" },
            "<h1>Hello, World!</h1>"
        )
    }

    func testEscapesText() {
        HtmlAssertEqual(
            h1 { #""Hello" 'World' & <FooBar>"# },
            #"<h1>"Hello" 'World' &amp; &lt;FooBar&gt;</h1>"#
        )
    }

    func testDoesNotEscapeRawText() {
        HtmlAssertEqual(
            h1 { HtmlRaw(#""Hello" 'World' & <FooBar>"#) },
            #"<h1>"Hello" 'World' & <FooBar></h1>"#
        )
    }

    func testRendersListsOfText() {
        HtmlAssertEqual(
            div {
                "Hello, "
                "World!"
            },
            "<div>Hello, World!</div>"
        )
    }

    func testRendersTextWithInlineTags() {
        HtmlAssertEqual(
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
        HtmlAssertEqual(
            div {
                HtmlComment("Hello !--> World")
            },
            "<div><!--Hello !--&gt; World--></div>"
        )
    }

    func testRendersRaw() {
        HtmlAssertEqual(
            div {
                HtmlRaw(#"<my-tag>"&amp;"</my-tag>"#)
            },
            #"<div><my-tag>"&amp;"</my-tag></div>"#
        )
    }
}
