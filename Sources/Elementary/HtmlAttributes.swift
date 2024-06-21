public enum HTMLAttributeValue {}

// global attributes
public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    static func custom(name: String, value: String) -> Self {
        HTMLAttribute(name: name, value: value)
    }

    static func id(_ value: String) -> Self {
        HTMLAttribute(name: "id", value: value)
    }

    static func `class`(_ value: String) -> Self {
        HTMLAttribute(name: "class", value: value, mergeMode: .appendValue(" "))
    }

    static func data(_ key: String, value: String) -> Self {
        HTMLAttribute(name: "data-\(key)", value: value)
    }

    static func style(_ value: String) -> Self {
        HTMLAttribute(name: "style", value: value, mergeMode: .appendValue(";"))
    }

    static func title(_ value: String) -> Self {
        HTMLAttribute(name: "title", value: value)
    }

    static func lang(_ value: String) -> Self {
        HTMLAttribute(name: "lang", value: value)
    }

    static var hidden: Self {
        HTMLAttribute(name: "hidden", value: nil)
    }

    static func tabindex(_ index: Int) -> Self {
        HTMLAttribute(name: "tabindex", value: "\(index)")
    }
}

// meta tag attributes
public extension HTMLAttribute where Tag == HTMLTag.meta {
    struct Name: Sendable {
        var value: String

        public static let author = Name(value: "author")
        public static let description = Name(value: "description")
        public static let keywords = Name(value: "keywords")
        public static let viewport = Name(value: "viewport")
    }

    static func name(_ name: Name) -> Self {
        HTMLAttribute(name: "name", value: name.value)
    }

    static func content(_ value: String) -> Self {
        HTMLAttribute(name: "content", value: value)
    }
}

// href attribute
public extension HTMLTrait.Attributes {
    protocol href {}
}

extension HTMLTag.a: HTMLTrait.Attributes.href {}
extension HTMLTag.area: HTMLTrait.Attributes.href {}
extension HTMLTag.base: HTMLTrait.Attributes.href {}
extension HTMLTag.link: HTMLTrait.Attributes.href {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.href {
    static func href(_ value: String) -> Self {
        HTMLAttribute(name: "href", value: value)
    }
}

// src attribute
public extension HTMLTrait.Attributes {
    protocol src {}
}

extension HTMLTag.audio: HTMLTrait.Attributes.src {}
extension HTMLTag.embed: HTMLTrait.Attributes.src {}
extension HTMLTag.iframe: HTMLTrait.Attributes.src {}
extension HTMLTag.img: HTMLTrait.Attributes.src {}
extension HTMLTag.input: HTMLTrait.Attributes.src {}
extension HTMLTag.script: HTMLTrait.Attributes.src {}
extension HTMLTag.source: HTMLTrait.Attributes.src {}
extension HTMLTag.track: HTMLTrait.Attributes.src {}
extension HTMLTag.video: HTMLTrait.Attributes.src {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.src {
    static func src(_ url: String) -> Self {
        HTMLAttribute(name: "src", value: url)
    }
}

// target attribute
public extension HTMLTrait.Attributes {
    protocol target {}
}

extension HTMLTag.a: HTMLTrait.Attributes.target {}
extension HTMLTag.area: HTMLTrait.Attributes.target {}
extension HTMLTag.base: HTMLTrait.Attributes.target {}
extension HTMLTag.form: HTMLTrait.Attributes.target {}

public extension HTMLAttributeValue {
    struct Target: ExpressibleByStringLiteral, Sendable, Equatable {
        public var value: String
        public init(stringLiteral value: String) {
            self.value = value
        }

        public static var blank: Self { "_blank" }
        public static var parent: Self { "_parent" }
        public static var `self`: Self { "_self" }
        public static var top: Self { "_top" }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.target {
    static func target(_ target: HTMLAttributeValue.Target) -> Self {
        HTMLAttribute(name: "target", value: target.value)
    }
}

// autofocus attribute
public extension HTMLTrait.Attributes {
    protocol autofocus {}
}

extension HTMLTag.button: HTMLTrait.Attributes.autofocus {}
extension HTMLTag.input: HTMLTrait.Attributes.autofocus {}
extension HTMLTag.select: HTMLTrait.Attributes.autofocus {}
extension HTMLTag.textarea: HTMLTrait.Attributes.autofocus {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.autofocus {
    static var autofocus: Self {
        HTMLAttribute(name: "autofocus", value: nil)
    }
}

// form tag attributes

public extension HTMLAttribute where Tag == HTMLTag.form {
    struct Method: Sendable, Equatable {
        var value: String

        public static var get: Self { .init(value: "get") }
        public static var post: Self { .init(value: "post") }
    }

    static func action(_ url: String) -> Self {
        HTMLAttribute(name: "action", value: url)
    }

    static func method(_ method: Method) -> Self {
        HTMLAttribute(name: "method", value: method.value)
    }
}

// input tag attributes
public extension HTMLAttribute where Tag == HTMLTag.input {
    struct InputType: Sendable, Equatable {
        var value: String

        public static var button: Self { .init(value: "button") }
        public static var checkbox: Self { .init(value: "checkbox") }
        public static var color: Self { .init(value: "color") }
        public static var date: Self { .init(value: "date") }
        public static var datetimeLocal: Self { .init(value: "datetime-local") }
        public static var email: Self { .init(value: "email") }
        public static var file: Self { .init(value: "file") }
        public static var hidden: Self { .init(value: "hidden") }
        public static var image: Self { .init(value: "image") }
        public static var month: Self { .init(value: "month") }
        public static var number: Self { .init(value: "number") }
        public static var password: Self { .init(value: "password") }
        public static var radio: Self { .init(value: "radio") }
        public static var range: Self { .init(value: "range") }
        public static var reset: Self { .init(value: "reset") }
        public static var search: Self { .init(value: "search") }
        public static var submit: Self { .init(value: "submit") }
        public static var tel: Self { .init(value: "tel") }
        public static var text: Self { .init(value: "text") }
        public static var time: Self { .init(value: "time") }
        public static var url: Self { .init(value: "url") }
        public static var week: Self { .init(value: "week") }
    }

    static func type(_ type: InputType) -> Self {
        HTMLAttribute(name: "type", value: type.value)
    }

    static func name(_ name: String) -> Self {
        HTMLAttribute(name: "name", value: name)
    }

    static func value(_ value: String) -> Self {
        HTMLAttribute(name: "value", value: value)
    }
}

// label tag attributes
public extension HTMLAttribute where Tag == HTMLTag.label {
    static func `for`(_ id: String) -> Self {
        HTMLAttribute(name: "for", value: id)
    }
}
