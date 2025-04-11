public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    static func on(_ event: HTMLAttributeValue.MouseEvent, _ script: String) -> Self { .init(on: event, script: script) }
    static func on(_ event: HTMLAttributeValue.FormEvent, _ script: String) -> Self { .init(on: event, script: script) }
    static func on(_ event: HTMLAttributeValue.KeyboardEvent, _ script: String) -> Self { .init(on: event, script: script) }
}

// TODO: window events, drag events, media events (more scoped)

public extension HTMLAttributeValue {
    struct MouseEvent: HTMLEventName {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var click: Self { .init(rawValue: "click") }
        public static var dblclick: Self { .init(rawValue: "dblclick") }
        public static var mousedown: Self { .init(rawValue: "mousedown") }
        public static var mousemove: Self { .init(rawValue: "mousemove") }
        public static var mouseout: Self { .init(rawValue: "mouseout") }
        public static var mouseover: Self { .init(rawValue: "mouseover") }
        public static var mouseup: Self { .init(rawValue: "mouseup") }
        public static var wheel: Self { .init(rawValue: "wheel") }
    }

    struct KeyboardEvent: HTMLEventName {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var keydown: Self { .init(rawValue: "keydown") }
        public static var keypress: Self { .init(rawValue: "keypress") }
        public static var keyup: Self { .init(rawValue: "keyup") }
    }

    struct FormEvent: HTMLEventName {
        public var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static var blur: Self { .init(rawValue: "blur") }
        public static var change: Self { .init(rawValue: "change") }
        public static var contextmenu: Self { .init(rawValue: "contextmenu") }
        public static var focus: Self { .init(rawValue: "focus") }
        public static var input: Self { .init(rawValue: "input") }
        public static var invalid: Self { .init(rawValue: "invalid") }
        public static var reset: Self { .init(rawValue: "reset") }
        public static var search: Self { .init(rawValue: "search") }
        public static var select: Self { .init(rawValue: "select") }
        public static var submit: Self { .init(rawValue: "submit") }
    }
}

protocol HTMLEventName: RawRepresentable {}

extension HTMLAttribute {
    init(on eventName: some HTMLEventName, script: String) {
        self.init(name: "on\(eventName.rawValue)", value: script)
    }
}
