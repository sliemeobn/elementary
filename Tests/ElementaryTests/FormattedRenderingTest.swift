import Elementary
import XCTest

final class FormatedRenderingTests: XCTestCase {
    func testFormatsBlocks() {
        HTMLFormattedAssertEqual(
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
        HTMLFormattedAssertEqual(
            div { div { p { "Hello&" }; p { HTMLRaw("World&") } } },
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
        HTMLFormattedAssertEqual(
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
        HTMLFormattedAssertEqual(
            div { HTMLComment("Hello") },
            """
            <div><!--Hello--></div>
            """
        )
    }

    func testFormatsMixedContextInBlock() {
        HTMLFormattedAssertEqual(
            div {
                HTMLComment("Hello")
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
        HTMLFormattedAssertEqual(
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
        HTMLFormattedAssertEqual(
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
        HTMLFormattedAssertEqual(
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
        HTMLFormattedAssertEqual(
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
