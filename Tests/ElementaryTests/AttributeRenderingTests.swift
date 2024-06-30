import Elementary
import XCTest

final class AttributeRenderingTests: XCTestCase {
    func testRendersAnAttribute() async throws {
        try await HTMLAssertEqual(
            p(.id("foo")) {},
            #"<p id="foo"></p>"#
        )
    }

    func testRendersAttributes() async throws {
        try await HTMLAssertEqual(
            p(.id("foo"), .class("foo"), .hidden) {},
            #"<p id="foo" class="foo" hidden></p>"#
        )
    }

    func testEscapesAttributeValues() async throws {
        try await HTMLAssertEqual(
            p(.id("foo\""), .class("&foo<>")) {},
            #"<p id="foo&quot;" class="&amp;foo<>"></p>"#
        )
    }

    func testRendersAppliedAttributes() async throws {
        try await HTMLAssertEqual(
            p {}.attributes(.id("foo"), .class("bar")),
            #"<p id="foo" class="bar"></p>"#
        )
    }

    func testKeepsAttributeOrder() async throws {
        try await HTMLAssertEqual(
            p(.id("1")) { "yo" }.attributes(.class("2")).attributes(.lang("de-AT")),
            #"<p id="1" class="2" lang="de-AT">yo</p>"#
        )
    }

    func testAppliesConditionalAttributes() async throws {
        try await HTMLAssertEqual(
            img(.id("1")).attributes(.class("2"), .id("no"), when: false).attributes(.style("2"), when: true),
            #"<img id="1" style="2">"#
        )
    }

    func testMergesClassAndStyleByDefault() async throws {
        try await HTMLAssertEqual(
            p(.class("first")) {}.attributes(.class("second"), .style("style1")).attributes(.style("style2")),
            #"<p class="first second" style="style1;style2"></p>"#
        )
    }

    func testOverridesByDefault() async throws {
        try await HTMLAssertEqual(
            br(.id("foo")).attributes(.hidden, .id("bar")).attributes(.id("baz")),
            #"<br id="baz" hidden>"#
        )
    }

    func testRespectsCustomMergeMode() async throws {
        try await HTMLAssertEqual(
            br(.id("1"), .data("bar", value: "baz"))
                .attributes(.id("2").mergedBy(.appending(seperatedBy: "-")))
                .attributes(.id("3").mergedBy(.ignoring))
                .attributes(.data("bar", value: "baq").mergedBy(.appending(seperatedBy: ""))),
            #"<br id="1-2" data-bar="bazbaq">"#
        )
    }

    func testRendersMouseEventAttribute() async throws {
        try await HTMLAssertEqual(
            p(.on(.click, "doIt()")) {},
            #"<p onclick="doIt()"></p>"#
        )
    }

    func testRendersKeyboardEventAttribute() async throws {
        try await HTMLAssertEqual(
            p(.on(.keydown, "doIt()")) {},
            #"<p onkeydown="doIt()"></p>"#
        )
    }

    func testRendersFormEventAttribute() async throws {
        try await HTMLAssertEqual(
            p(.on(.blur, "doIt()")) {},
            #"<p onblur="doIt()"></p>"#
        )
    }

    func testRendersMetaCharset() async throws {
        try await HTMLAssertEqual(
            meta(.charset(.utf8)),
            #"<meta charset="UTF-8">"#
        )
    }

    func testRendersRequired() async throws {
        try await HTMLAssertEqual(
            input(.type(.text), .required),
            #"<input type="text" required>"#
        )
    }
}
