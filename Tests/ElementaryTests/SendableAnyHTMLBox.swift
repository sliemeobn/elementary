import Elementary
import XCTest

final class SendOnceHTMLValueTests: XCTestCase {
    func testHoldsSendableValue() {
        let html = div { "Hello, World!" }
        let box = _SendableAnyHTMLBox(html)
        XCTAssertNotNil(box.tryTake())
        XCTAssertNotNil(box.tryTake())
    }

    #if compiler(>=6.0)
    func testHoldsNonSendable() throws {
        guard #available(macOS 15.0, *) else {
            throw XCTSkip("Requires macOS 15.0")
        }

        let html = MyComponent()
        let box = _SendableAnyHTMLBox(html)
        XCTAssertNotNil(box.tryTake())
        XCTAssertNil(box.tryTake())
    }
    #endif
}

class NonSendable {
    var x: Int = 0
}

struct MyComponent: HTML {
    let ns = NonSendable()
    var content: some HTML {
        div { "\(ns.x)" }
    }
}
