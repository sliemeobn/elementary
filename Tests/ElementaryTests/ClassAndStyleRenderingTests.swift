import Elementary
import XCTest

final class ClassAndStyleRenderingTests: XCTestCase {
    func testRendersClasses() async throws {
        try await HTMLAssertEqual(
            p(.class(["foo", "bar"])) {},
            #"<p class="foo bar"></p>"#
        )
    }

    func testMergesClassesKeepingSequence() async throws {
        try await HTMLAssertEqual(
            p(
                .class(["foo", "bar"]),
                .class(["foo", "baz"])
            ) {}
            .attributes(
                .class("do not touch"),
                .class(["baz", "end"])
            ),
            #"<p class="foo bar baz do not touch end"></p>"#
        )
    }

    func testRendersStyles() async throws {
        try await HTMLAssertEqual(
            p(.style(["color": "red", "font-size": "16px"])) {},
            #"<p style="color:red;font-size:16px"></p>"#
        )
    }

    func testMergesStylesKeepingSequence() async throws {
        try await HTMLAssertEqual(
            p(.style(["color": "red", "font-size": "16px"])) {}
                .attributes(
                    .style("do: not-touch"),
                    .style(["font-size": "24px", "flex": "auto"])
                ),
            #"<p style="color:red;do: not-touch;font-size:24px;flex:auto"></p>"#
        )
    }
}
