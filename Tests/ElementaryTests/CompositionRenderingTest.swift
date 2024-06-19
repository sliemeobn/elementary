import Elementary
import XCTest

final class CompositionRenderingTests: XCTestCase {
    func testRendersADocument() {
        HtmlAssertEqual(
            MyPage(text: "my text"),
            #"<!DOCTYPE html><html><head><title>Foo</title><meta name="author" content="Me"><meta name="description" content="Test page"></head><body><div><h1>Hello, world!</h1><p>my text</p></div></body></html>"#
        )
    }

    func testRendersAComponent() {
        HtmlAssertEqual(
            MyList(items: ["one", "two"], selectedIndex: 1),
            #"<ul><li id="1">one</li><li class="selected" id="2">two</li></ul>"#
        )
    }
}

struct MyPage: HtmlDocument {
    var text: String

    var title: String = "Foo"

    var head: some Html {
        meta(.name(.author), .content("Me"))
        meta(.name(.description), .content("Test page"))
    }

    var body: some Html {
        div {
            h1 { "Hello, world!" }
            p { text }
        }
    }
}

struct MyList: Html {
    var items: [String]
    var selectedIndex: Int

    var content: some Html {
        ul {
            for (index, item) in items.enumerated() {
                MyListItem(text: item, isSelected: index == selectedIndex)
                    .attributes(.id("\(index + 1)"))
            }
        }
    }
}

struct MyListItem: Html {
    var text: String
    var isSelected: Bool = false

    var content: some Html<HtmlTag.li> {
        li { text }
            .attributes(.class("selected"), when: isSelected)
    }
}
