import Elementary
import XCTest

final class AsyncRenderingTests: XCTestCase {
    func testRendersAsyncContent() async throws {
        try await HTMLAssertEqualAsyncOnly(
            AsyncContent {
                let text = await getValue()
                "Waiting for "
                span { text }
            },
            "Waiting for <span>late response</span>"
        )
    }

    func testAsyncElementInTuple() async throws {
        try await HTMLAssertEqualAsyncOnly(
            div {
                AwaitedP(number: 1)
                AwaitedP(number: 2)
                AwaitedP(number: 3)
            },
            "<div><p>1</p><p>2</p><p>3</p></div>"
        )
    }

    func testImplicitlyAsyncContent() async throws {
        try await HTMLAssertEqualAsyncOnly(
            p(.id("hello")) {
                let text = await getValue()
                "Waiting for \(text)"
            },
            #"<p id="hello">Waiting for late response</p>"#
        )
    }

    func testNestedImplicitAsyncContent() async throws {
        try await HTMLAssertEqualAsyncOnly(
            div(attributes: [.class("c1")]) {
                p {
                    await getValue()
                }
                "again \(await getValue())"
                p(.class("c2")) {
                    "and again \(await getValue())"
                }
            },
            #"<div class="c1"><p>late response</p>again late response<p class="c2">and again late response</p></div>"#
        )
    }
}

private struct AwaitedP: HTML {
    var number: Int
    var content: some HTML {
        AsyncContent {
            let _ = try await Task.sleep(for: .milliseconds(1))
            p { "\(number)" }
        }
    }
}

private func getValue() async -> String {
    await Task.yield() // just for fun
    return "late response"
}
