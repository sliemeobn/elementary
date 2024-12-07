import Elementary
import XCTest

@available(macOS 15.0, *)
final class SendOnceHTMLValueTests: XCTestCase {
    func testHoldsSendableValue() {
        let html = div { "Hello, World!" }
        let box = _SendableAnyHTMLBox(html)
        XCTAssertNotNil(box.tryTake())
        XCTAssertNotNil(box.tryTake())
    }

    #if swift(>=6.0)
    func testHoldsNonSendable() {
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
