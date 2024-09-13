import Elementary
import XCTest

final class AsyncRenderingTests: XCTestCase {
    func testRendersAwaitedHTML() async throws {
        try await HTMLAssertEqualAsyncOnly(
            p {
                AsyncHTML {
                    let text = await getValue()
                    "Waiting for "
                    span { text }
                }
            },
            "<p>Waiting for <span>late response</span></p>"
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

    func testImplicitAsyncContent() async throws {
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
                await getValue()
                p {
                    "again \(await getValue())"
                }
                p(.class("c2")) {
                    "and again \(await getValue())"
                }
            },
            #"<div class="c1">late response<p>again late response</p><p class="c2">and again late response</p></div>"#
        )
    }
}

private struct AwaitedP: HTML {
    var number: Int
    var content: some HTML {
        AsyncHTML {
            let _ = try await Task.sleep(for: .milliseconds(1))
            p { "\(number)" }
        }
    }
}

private func getValue() async -> String {
    await Task.yield() // just for fun
    return "late response"
}
