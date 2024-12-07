#if swift(>=6.0) && !hasFeature(Embedded)
import Synchronization

@available(macOS 15.0, *)
final class SendOnceBox: Sendable, SendOnceBoxing {
    // final class SendOnceBox<Value>: Sendable, SendOnceBoxing {
    typealias Value = any HTML
    // NOTE: generics+Synchronization crashes the compiler ATM
    // https://github.com/swiftlang/swift/issues/78048

    let mutex: Mutex<Value?>

    init(_ value: sending Value) {
        mutex = Mutex(value)
    }

    func tryTake() -> sending Value? {
        mutex.withLock { value -> sending Value? in
            let result = value
            value = nil
            return result
        }
    }
}

// NOTE: this is for macOS runtime availability of SendOnceBox and can be removed when macOS 15 is the minimum
protocol SendOnceBoxing<Value>: AnyObject, Sendable {
    associatedtype Value
    func tryTake() -> sending Value?
}
#endif
