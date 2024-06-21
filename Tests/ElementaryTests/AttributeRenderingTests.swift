import Elementary
import XCTest

final class AttributeRenderingTests: XCTestCase {
    func testRendersAnAttribute() {
        HTMLAssertEqual(
            p(.id("foo")) {},
            #"<p id="foo"></p>"#
        )
    }

    func testRendersAttributes() {
        HTMLAssertEqual(
            p(.id("foo"), .class("foo"), .hidden) {},
            #"<p id="foo" class="foo" hidden></p>"#
        )
    }

    func testEscapesAttributeValues() {
        HTMLAssertEqual(
            p(.id("foo\""), .class("&foo<>")) {},
            #"<p id="foo&quot;" class="&amp;foo<>"></p>"#
        )
    }

    func testRendersAppliedAttributes() {
        HTMLAssertEqual(
            p {}.attributes(.id("foo"), .class("bar")),
            #"<p id="foo" class="bar"></p>"#
        )
    }

    func testKeepsAttributeOrder() {
        HTMLAssertEqual(
            p(.id("1")) { "yo" }.attributes(.class("2")).attributes(.lang("de-AT")),
            #"<p id="1" class="2" lang="de-AT">yo</p>"#
        )
    }

    func testAppliesConditionalAttributes() {
        HTMLAssertEqual(
            img(.id("1")).attributes(.class("2"), .id("no"), when: false).attributes(.style("2"), when: true),
            #"<img id="1" style="2">"#
        )
    }

    func testMergesClassAndStyleByDefault() {
        HTMLAssertEqual(
            p(.class("first")) {}.attributes(.class("second"), .style("style1")).attributes(.style("style2")),
            #"<p class="first second" style="style1;style2"></p>"#
        )
    }

    func testOverridesByDefault() {
        HTMLAssertEqual(
            br(.id("foo")).attributes(.hidden, .id("bar")).attributes(.id("baz")),
            #"<br id="baz" hidden>"#
        )
    }
}
