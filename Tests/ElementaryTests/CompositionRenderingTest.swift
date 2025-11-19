import Elementary
import XCTest

final class CompositionRenderingTests: XCTestCase {
    func testRendersADocument() async throws {
        try await HTMLAssertEqual(
            MyPage(text: "my text"),
            #"<!DOCTYPE html><html lang="en"><head><title>Foo</title><meta name="author" content="Me"><meta name="description" content="Test page"></head><body><div><h1>Hello, world!</h1><p>my text</p></div></body></html>"#
        )
    }

    func testRendersARTLPage() async throws {
        try await HTMLAssertEqual(
            MyRTLPage(),
            #"<!DOCTYPE html><html lang="he" dir="rtl"><head><title>שלום עולם</title></head><body><h1>מה קורה?</h1></body></html>"#
        )
    }

    func testRendersAComponent() async throws {
        try await HTMLAssertEqual(
            MyList(items: ["one", "two"], selectedIndex: 1),
            #"<ul><li id="1">one</li><li class="selected" id="2">two</li></ul>"#
        )
    }

    func testRendersForEachWithRange() async throws {
        try await HTMLAssertEqual(
            ForEach(1...3) { index in
                li { "Item \(index)" }
            },
            #"<li>Item 1</li><li>Item 2</li><li>Item 3</li>"#
        )
    }

    func testRendersForEachWithLazyMap() async throws {
        try await HTMLAssertEqual(
            ForEach([1, 2, 3].lazy.map { $0 * 10 }) { index in
                li { "Item \(index)" }
            },
            #"<li>Item 10</li><li>Item 20</li><li>Item 30</li>"#
        )
    }
}

struct MyPage: HTMLDocument {
    var text: String

    var title = "Foo"
    var lang = "en"

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

    var body: some HTML {
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

    var body: some HTML<HTMLTag.li> {
        li { text }
            .attributes(.class("selected"), when: isSelected)
    }
}

struct MyRTLPage: HTMLDocument {
    var title = "שלום עולם"
    var lang = "he"
    var dir: HTMLAttributeValue.Direction = .rtl

    var head: some HTML {
        EmptyHTML()
    }

    var body: some HTML {
        h1 { "מה קורה?" }
    }
}
