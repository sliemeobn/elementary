import Elementary
import XCTest

final class FormatedRenderingTests: XCTestCase {
    func testFormatsBlocks() {
        HtmlFormattedAssertEqual(
            div { div { p {}; p {} } },
            """
            <div>
              <div>
                <p></p>
                <p></p>
              </div>
            </div>
            """
        )
    }

    func testFormatsInlineTextAndRaw() {
        HtmlFormattedAssertEqual(
            div { div { p { "Hello&" }; p { HtmlRaw("World&") } } },
            """
            <div>
              <div>
                <p>Hello&amp;</p>
                <p>World&</p>
              </div>
            </div>
            """
        )
    }

    func testFormatsLineBreaks() {
        HtmlFormattedAssertEqual(
            p {
                """
                This,
                is <a>
                  multiline test.
                """
            },
            """
            <p>
              This,
              is &lt;a&gt;
                multiline test.
            </p>
            """
        )
    }

    func testFormatsComments() {
        HtmlFormattedAssertEqual(
            div { HtmlComment("Hello") },
            """
            <div><!--Hello--></div>
            """
        )
    }

    func testFormatsMixedContextInBlock() {
        HtmlFormattedAssertEqual(
            div {
                HtmlComment("Hello")
                p { "World" }
            },
            """
            <div>
              <!--Hello-->
              <p>World</p>
            </div>
            """
        )
    }

    func testFormatsInlineElements() {
        HtmlFormattedAssertEqual(
            div {
                "Hello, "
                span { "Wor" }
                b { "ld" }
            },
            """
            <div>Hello, <span>Wor</span><b>ld</b></div>
            """
        )
    }

    func testFormatsUnpairedTags() {
        HtmlFormattedAssertEqual(
            div {
                "Hello"
                br()
                "World"
            },
            """
            <div>
              Hello
              <br>
              World
            </div>
            """
        )
    }

    func testFormatsMixed() {
        HtmlFormattedAssertEqual(
            div {
                "Hello"
                p { "World" }
                "Ok"
                img()
                "Ok"

            },
            """
            <div>
              Hello
              <p>World</p>
              Ok
              <img>
              Ok
            </div>
            """
        )
    }

    func testFormatsAttributes() {
        HtmlFormattedAssertEqual(
            div(.id("1")) {
                "Hello "
                span(.class("foo")) { "World" }
                p(.class("bar")) { "!" }
            },
            """
            <div id="1">
              Hello <span class="foo">World</span>
              <p class="bar">!</p>
            </div>
            """
        )
    }
}
