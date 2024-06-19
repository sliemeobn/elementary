import Elementary
import XCTest

final class AttributeRenderingTests: XCTestCase {
    func testRendersAnAttribute() {
        HtmlAssertEqual(
            p(.id("foo")) {},
            #"<p id="foo"></p>"#
        )
    }

    func testRendersAttributes() {
        HtmlAssertEqual(
            p(.id("foo"), .class("foo"), .hidden) {},
            #"<p id="foo" class="foo" hidden></p>"#
        )
    }

    func testEscapesAttributeValues() {
        HtmlAssertEqual(
            p(.id("foo\""), .class("&foo<>")) {},
            #"<p id="foo&quot;" class="&amp;foo<>"></p>"#
        )
    }

    func testRendersAppliedAttributes() {
        HtmlAssertEqual(
            p {}.attributes(.id("foo"), .class("bar")),
            #"<p id="foo" class="bar"></p>"#
        )
    }

    func testKeepsAttributeOrder() {
        HtmlAssertEqual(
            p(.id("1")) { "yo" }.attributes(.class("2")).attributes(.lang("de-AT")),
            #"<p id="1" class="2" lang="de-AT">yo</p>"#
        )
    }

    func testAppliesConditionalAttributes() {
        HtmlAssertEqual(
            img(.id("1")).attributes(.class("2"), .id("no"), when: false).attributes(.style("2"), when: true),
            #"<img id="1" style="2">"#
        )
    }

    func testMergesClassAndStyleByDefault() {
        HtmlAssertEqual(
            p(.class("first")) {}.attributes(.class("second"), .style("style1")).attributes(.style("style2")),
            #"<p class="first second" style="style1;style2"></p>"#
        )
    }

    func testOverridesByDefault() {
        HtmlAssertEqual(
            br(.id("foo")).attributes(.hidden, .id("bar")).attributes(.id("baz")),
            #"<br id="baz" hidden>"#
        )
    }
}
