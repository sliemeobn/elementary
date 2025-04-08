import Elementary
import XCTest

final class TagRenderingTests: XCTestCase {
    func testRendersEmptyTag() async throws {
        try await HTMLAssertEqual(
            p {},
            "<p></p>"
        )
    }

    func testRendersNestedTags() async throws {
        try await HTMLAssertEqual(
            div { p {} },
            "<div><p></p></div>"
        )
    }

    func testRendersSelfClosingTag() async throws {
        try await HTMLAssertEqual(
            br(),
            "<br>"
        )
    }

    func testRendersTuples() async throws {
        try await HTMLAssertEqual(
            div {
                h1 {}
                p {}
            },
            "<div><h1></h1><p></p></div>"
        )
    }

    func testRendersOptionals() async throws {
        try await HTMLAssertEqual(
            div {
                if true {
                    p {}
                }
            },
            "<div><p></p></div>"
        )

        try await HTMLAssertEqual(
            div {
                if false {
                    p {}
                }
            },
            "<div></div>"
        )
    }

    func testRendersConditionals() async throws {
        try await HTMLAssertEqual(
            div {
                if true {
                    p {}
                } else {
                    span {}
                }
            },
            "<div><p></p></div>"
        )

        try await HTMLAssertEqual(
            div {
                if false {
                    p {}
                } else {
                    span {}
                }
            },
            "<div><span></span></div>"
        )
    }

    func testRendersLists() async throws {
        try await HTMLAssertEqual(
            div {
                for _ in 0..<3 {
                    p {}
                }
            },
            "<div><p></p><p></p><p></p></div>"
        )
    }
}
