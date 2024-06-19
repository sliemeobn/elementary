public enum HtmlAttributeValue {}

// global attributes
public extension HtmlAttribute where Tag: HtmlTrait.Attributes.Global {
    static func custom(name: String, value: String) -> Self {
        HtmlAttribute(name: name, value: value)
    }

    static func id(_ value: String) -> Self {
        HtmlAttribute(name: "id", value: value)
    }

    static func `class`(_ value: String) -> Self {
        HtmlAttribute(name: "class", value: value, mergeMode: .appendValue(" "))
    }

    static func data(_ key: String, value: String) -> Self {
        HtmlAttribute(name: "data-\(key)", value: value)
    }

    static func style(_ value: String) -> Self {
        HtmlAttribute(name: "style", value: value, mergeMode: .appendValue(";"))
    }

    static func title(_ value: String) -> Self {
        HtmlAttribute(name: "title", value: value)
    }

    static func lang(_ value: String) -> Self {
        HtmlAttribute(name: "lang", value: value)
    }

    static var hidden: Self {
        HtmlAttribute(name: "hidden", value: nil)
    }

    static func tabindex(_ index: Int) -> Self {
        HtmlAttribute(name: "tabindex", value: "\(index)")
    }
}

// meta tag attributes
public extension HtmlAttribute where Tag == HtmlTag.meta {
    struct Name: Sendable {
        var value: String

        public static let author = Name(value: "author")
        public static let description = Name(value: "description")
        public static let keywords = Name(value: "keywords")
        public static let viewport = Name(value: "viewport")
    }

    static func name(_ name: Name) -> Self {
        HtmlAttribute(name: "name", value: name.value)
    }

    static func content(_ value: String) -> Self {
        HtmlAttribute(name: "content", value: value)
    }
}

// href attribute
public extension HtmlTrait.Attributes {
    protocol href {}
}

extension HtmlTag.a: HtmlTrait.Attributes.href {}
extension HtmlTag.area: HtmlTrait.Attributes.href {}
extension HtmlTag.base: HtmlTrait.Attributes.href {}
extension HtmlTag.link: HtmlTrait.Attributes.href {}

public extension HtmlAttribute where Tag: HtmlTrait.Attributes.href {
    static func href(_ value: String) -> Self {
        HtmlAttribute(name: "href", value: value)
    }
}

// src attribute
public extension HtmlTrait.Attributes {
    protocol src {}
}

extension HtmlTag.audio: HtmlTrait.Attributes.src {}
extension HtmlTag.embed: HtmlTrait.Attributes.src {}
extension HtmlTag.iframe: HtmlTrait.Attributes.src {}
extension HtmlTag.img: HtmlTrait.Attributes.src {}
extension HtmlTag.input: HtmlTrait.Attributes.src {}
extension HtmlTag.script: HtmlTrait.Attributes.src {}
extension HtmlTag.source: HtmlTrait.Attributes.src {}
extension HtmlTag.track: HtmlTrait.Attributes.src {}
extension HtmlTag.video: HtmlTrait.Attributes.src {}

public extension HtmlAttribute where Tag: HtmlTrait.Attributes.src {
    static func src(_ url: String) -> Self {
        HtmlAttribute(name: "src", value: url)
    }
}

// target attribute
public extension HtmlTrait.Attributes {
    protocol target {}
}

extension HtmlTag.a: HtmlTrait.Attributes.target {}
extension HtmlTag.area: HtmlTrait.Attributes.target {}
extension HtmlTag.base: HtmlTrait.Attributes.target {}
extension HtmlTag.form: HtmlTrait.Attributes.target {}

public extension HtmlAttributeValue {
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

public extension HtmlAttribute where Tag: HtmlTrait.Attributes.target {
    static func target(_ target: HtmlAttributeValue.Target) -> Self {
        HtmlAttribute(name: "target", value: target.value)
    }
}

// autofocus attribute
public extension HtmlTrait.Attributes {
    protocol autofocus {}
}

extension HtmlTag.button: HtmlTrait.Attributes.autofocus {}
extension HtmlTag.input: HtmlTrait.Attributes.autofocus {}
extension HtmlTag.select: HtmlTrait.Attributes.autofocus {}
extension HtmlTag.textarea: HtmlTrait.Attributes.autofocus {}

public extension HtmlAttribute where Tag: HtmlTrait.Attributes.autofocus {
    static var autofocus: Self {
        HtmlAttribute(name: "autofocus", value: nil)
    }
}

// form tag attributes

public extension HtmlAttribute where Tag == HtmlTag.form {
    struct Method: Sendable, Equatable {
        var value: String

        public static var get: Self { .init(value: "get") }
        public static var post: Self { .init(value: "post") }
    }

    static func action(_ url: String) -> Self {
        HtmlAttribute(name: "action", value: url)
    }

    static func method(_ method: Method) -> Self {
        HtmlAttribute(name: "method", value: method.value)
    }
}

// input tag attributes
public extension HtmlAttribute where Tag == HtmlTag.input {
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
        HtmlAttribute(name: "type", value: type.value)
    }

    static func name(_ name: String) -> Self {
        HtmlAttribute(name: "name", value: name)
    }

    static func value(_ value: String) -> Self {
        HtmlAttribute(name: "value", value: value)
    }
}

// label tag attributes
public extension HtmlAttribute where Tag == HtmlTag.label {
    static func `for`(_ id: String) -> Self {
        HtmlAttribute(name: "for", value: id)
    }
}
