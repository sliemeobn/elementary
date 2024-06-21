import Elementary
import XCTest

final class CompositionRenderingTests: XCTestCase {
    func testRendersADocument() {
        HTMLAssertEqual(
            MyPage(text: "my text"),
            #"<!DOCTYPE html><html><head><title>Foo</title><meta name="author" content="Me"><meta name="description" content="Test page"></head><body><div><h1>Hello, world!</h1><p>my text</p></div></body></html>"#
        )
    }

    func testRendersAComponent() {
        HTMLAssertEqual(
            MyList(items: ["one", "two"], selectedIndex: 1),
            #"<ul><li id="1">one</li><li class="selected" id="2">two</li></ul>"#
        )
    }
}

struct MyPage: HTMLDocument {
    var text: String

    var title: String = "Foo"

    var head: some HTML {
        meta(.name(.author), .content("Me"))
        meta(.name(.description), .content("Test page"))
    }

    var body: some HTML {
        div {
            h1 { "Hello, world!" }
            p { text }
        }
    }
}

struct MyList: HTML {
    var items: [String]
    var selectedIndex: Int

    var content: some HTML {
        ul {
            for (index, item) in items.enumerated() {
                MyListItem(text: item, isSelected: index == selectedIndex)
                    .attributes(.id("\(index + 1)"))
            }
        }
    }
}

struct MyListItem: HTML {
    var text: String
    var isSelected: Bool = false

    var content: some HTML<HTMLTag.li> {
        li { text }
            .attributes(.class("selected"), when: isSelected)
    }
}
