import Elementary
import XCTest

final class TagRenderingTests: XCTestCase {
    func testRendersEmptyTag() {
        HtmlAssertEqual(
            p {},
            "<p></p>"
        )
    }

    func testRendersNestedTags() {
        HtmlAssertEqual(
            div { p {} },
            "<div><p></p></div>"
        )
    }

    func testRendersSelfClosingTag() {
        HtmlAssertEqual(
            br(),
            "<br>"
        )
    }

    func testRendersTuples() {
        HtmlAssertEqual(
            div {
                h1 {}
                p {}
            }, "<div><h1></h1><p></p></div>"
        )
    }

    func testRendersOptionals() {
        HtmlAssertEqual(
            div {
                if true {
                    p {}
                }
            }, "<div><p></p></div>"
        )

        HtmlAssertEqual(
            div {
                if false {
                    p {}
                }
            }, "<div></div>"
        )
    }

    func testRendersConditionals() {
        HtmlAssertEqual(
            div {
                if true {
                    p {}
                } else {
                    span {}
                }
            }, "<div><p></p></div>"
        )

        HtmlAssertEqual(
            div {
                if false {
                    p {}
                } else {
                    span {}
                }
            }, "<div><span></span></div>"
        )
    }

    func testRendersLists() {
        HtmlAssertEqual(
            div {
                for _ in 0 ..< 3 {
                    p {}
                }
            }, "<div><p></p><p></p><p></p></div>"
        )
    }
}
