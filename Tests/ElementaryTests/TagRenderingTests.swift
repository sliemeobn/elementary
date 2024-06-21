import Elementary
import XCTest

final class TagRenderingTests: XCTestCase {
    func testRendersEmptyTag() {
        HTMLAssertEqual(
            p {},
            "<p></p>"
        )
    }

    func testRendersNestedTags() {
        HTMLAssertEqual(
            div { p {} },
            "<div><p></p></div>"
        )
    }

    func testRendersSelfClosingTag() {
        HTMLAssertEqual(
            br(),
            "<br>"
        )
    }

    func testRendersTuples() {
        HTMLAssertEqual(
            div {
                h1 {}
                p {}
            }, "<div><h1></h1><p></p></div>"
        )
    }

    func testRendersOptionals() {
        HTMLAssertEqual(
            div {
                if true {
                    p {}
                }
            }, "<div><p></p></div>"
        )

        HTMLAssertEqual(
            div {
                if false {
                    p {}
                }
            }, "<div></div>"
        )
    }

    func testRendersConditionals() {
        HTMLAssertEqual(
            div {
                if true {
                    p {}
                } else {
                    span {}
                }
            }, "<div><p></p></div>"
        )

        HTMLAssertEqual(
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
        HTMLAssertEqual(
            div {
                for _ in 0 ..< 3 {
                    p {}
                }
            }, "<div><p></p><p></p><p></p></div>"
        )
    }
}
