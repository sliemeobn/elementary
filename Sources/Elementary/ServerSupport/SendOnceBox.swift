#if swift(>=6.0)
import Synchronization

@available(macOS 15.0, *)
final class SendOnceBox<V>: Sendable, SendOnceBoxing {
    let value: Mutex<V?>

    init(_ value: sending V) {
        self.value = Mutex(value)
    }

    func tryTake() -> sending V? {
        value.withLock { value -> sending V? in
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
