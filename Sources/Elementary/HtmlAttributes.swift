/// A namespace for value types used in attributes.
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
        HTMLAttribute(name: "class", value: value, mergedBy: .appending(seperatedBy: " "))
    }

    static func data(_ key: String, value: String) -> Self {
        HTMLAttribute(name: "data-\(key)", value: value)
    }

    static func style(_ value: String) -> Self {
        HTMLAttribute(name: "style", value: value, mergedBy: .appending(seperatedBy: ";"))
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

// dir attribute
public extension HTMLAttributeValue {
    struct Direction {
        var value: String

        public static var ltr: Self { .init(value: "ltr") }
        public static var rtl: Self { .init(value: "rtl") }
        public static var auto: Self { .init(value: "auto") }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.Global {
    static func dir(_ value: HTMLAttributeValue.Direction) -> Self {
        HTMLAttribute(name: "dir", value: value.value)
    }
}

// meta tag attributes
public extension HTMLAttribute where Tag == HTMLTag.meta {
    struct Name: Sendable, ExpressibleByStringLiteral {
        var value: String

        init(value: String) {
            self.value = value
        }

        public init(stringLiteral value: String) {
            self.value = value
        }

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

    static func property(_ value: String) -> Self {
        HTMLAttribute(name: "property", value: value)
    }
}

// link tag attributes
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/link
public extension HTMLAttribute where Tag == HTMLTag.link {
    public struct As: Sendable, ExpressibleByStringLiteral {
        var value: String

        init(value: String) {
            self.value = value
        }

        public init(stringLiteral value: String) {
            self.value = value
        }

        public static let audio = As(value: "audio")
        public static let document = As(value: "document")
        public static let embed = As(value: "embed")
        public static let fetch = As(value: "fetch")
        public static let font = As(value: "font")
        public static let image = As(value: "image")
        public static let object = As(value: "object")
        public static let script = As(value: "script")
        public static let style = As(value: "style")
        public static let track = As(value: "track")
        public static let video = As(value: "video")
        public static let worker = As(value: "worker")
        public static let author = As(value: "author")
    }

    public static func `as`(_ value: As) -> Self {
        HTMLAttribute(name: "as", value: value.value)
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
    struct Target: ExpressibleByStringLiteral, RawRepresentable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var blank: Self { "_blank" }
        public static var parent: Self { "_parent" }
        public static var `self`: Self { "_self" }
        public static var top: Self { "_top" }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.target {
    static func target(_ target: HTMLAttributeValue.Target) -> Self {
        HTMLAttribute(name: "target", value: target.rawValue)
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

// charset attribute
public extension HTMLTrait.Attributes {
    protocol charset {}
}

extension HTMLTag.meta: HTMLTrait.Attributes.charset {}
extension HTMLTag.script: HTMLTrait.Attributes.charset {}

public extension HTMLAttributeValue {
    struct CharacterSet: ExpressibleByStringLiteral, RawRepresentable, Sendable, Equatable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var utf8: Self { "UTF-8" }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.charset {
    static func charset(_ value: HTMLAttributeValue.CharacterSet) -> Self {
        HTMLAttribute(name: "charset", value: value.rawValue)
    }
}

// rel attribute
public extension HTMLTrait.Attributes {
    protocol rel {}
}

extension HTMLTag.a: HTMLTrait.Attributes.rel {}
extension HTMLTag.area: HTMLTrait.Attributes.rel {}
extension HTMLTag.link: HTMLTrait.Attributes.rel {}
extension HTMLTag.form: HTMLTrait.Attributes.rel {}

public extension HTMLAttributeValue {
    struct Relationship: ExpressibleByStringLiteral, RawRepresentable, Sendable, Equatable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var icon: Self { "icon" }
        public static var stylesheet: Self { "stylesheet" }
        public static var preload: Self { "preload" }
        public static var canonical: Self { "canonical" }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.rel {
    static func rel(_ value: HTMLAttributeValue.Relationship) -> Self {
        HTMLAttribute(name: "rel", value: value.rawValue)
    }
}

// required attribute
public extension HTMLTrait.Attributes {
    protocol required {}
}

extension HTMLTag.input: HTMLTrait.Attributes.required {}
extension HTMLTag.select: HTMLTrait.Attributes.required {}
extension HTMLTag.textarea: HTMLTrait.Attributes.required {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.required {
    static var required: Self {
        HTMLAttribute(name: "required", value: nil)
    }
}

// disabled attribute
public extension HTMLTrait.Attributes {
    protocol disabled {}
}

extension HTMLTag.button: HTMLTrait.Attributes.disabled {}
extension HTMLTag.fieldset: HTMLTrait.Attributes.disabled {}
extension HTMLTag.input: HTMLTrait.Attributes.disabled {}
extension HTMLTag.optgroup: HTMLTrait.Attributes.disabled {}
extension HTMLTag.option: HTMLTrait.Attributes.disabled {}
extension HTMLTag.select: HTMLTrait.Attributes.disabled {}
extension HTMLTag.textarea: HTMLTrait.Attributes.disabled {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.disabled {
    static var disabled: Self {
        HTMLAttribute(name: "disabled", value: nil)
    }
}

// autocomplete attribute
public extension HTMLTrait.Attributes {
    protocol autocomplete {}
}

extension HTMLTag.form: HTMLTrait.Attributes.autocomplete {}
extension HTMLTag.input: HTMLTrait.Attributes.autocomplete {}
extension HTMLTag.select: HTMLTrait.Attributes.autocomplete {}
extension HTMLTag.textarea: HTMLTrait.Attributes.autocomplete {}

public extension HTMLAttributeValue {
    struct AutoComplete: ExpressibleByStringLiteral, RawRepresentable, Sendable, Equatable {
        public var rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(stringLiteral value: String) {
            rawValue = value
        }

        public static var on: Self { "on" }
        public static var off: Self { "off" }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.autocomplete {
    static func autocomplete(_ value: HTMLAttributeValue.AutoComplete) -> Self {
        HTMLAttribute(name: "autocomplete", value: value.rawValue)
    }
}

// label attribute
public extension HTMLTrait.Attributes {
    protocol label {}
}

extension HTMLTag.optgroup: HTMLTrait.Attributes.label {}
extension HTMLTag.option: HTMLTrait.Attributes.label {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.label {
    static func label(_ value: String) -> Self {
        HTMLAttribute(name: "label", value: value)
    }
}

// form attribute
public extension HTMLTrait.Attributes {
    protocol form {}
}

extension HTMLTag.button: HTMLTrait.Attributes.form {}
extension HTMLTag.fieldset: HTMLTrait.Attributes.form {}
extension HTMLTag.input: HTMLTrait.Attributes.form {}
extension HTMLTag.label: HTMLTrait.Attributes.form {}
extension HTMLTag.option: HTMLTrait.Attributes.form {}
extension HTMLTag.select: HTMLTrait.Attributes.form {}
extension HTMLTag.textarea: HTMLTrait.Attributes.form {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.form {
    static func form(_ id: String) -> Self {
        HTMLAttribute(name: "form", value: id)
    }
}

// name attribute (for basic string case, meta has its own typed name attribute)
public extension HTMLTrait.Attributes {
    protocol name {}
}

extension HTMLTag.button: HTMLTrait.Attributes.name {}
extension HTMLTag.fieldset: HTMLTrait.Attributes.name {}
extension HTMLTag.form: HTMLTrait.Attributes.name {}
extension HTMLTag.iframe: HTMLTrait.Attributes.name {}
extension HTMLTag.input: HTMLTrait.Attributes.name {}
extension HTMLTag.select: HTMLTrait.Attributes.name {}
extension HTMLTag.textarea: HTMLTrait.Attributes.name {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.name {
    static func name(_ value: String) -> Self {
        HTMLAttribute(name: "name", value: value)
    }
}

// crossorigin attribute
public extension HTMLTrait.Attributes {
    protocol crossorigin {}
}

extension HTMLTag.script: HTMLTrait.Attributes.crossorigin {}
extension HTMLTag.link: HTMLTrait.Attributes.crossorigin {}

public extension HTMLAttributeValue {
    struct CrossOrigin: Sendable, Equatable {
        var value: String

        public static var anonymous: Self { .init(value: "anonymous") }
        public static var useCredentials: Self { .init(value: "use-credentials") }
    }
}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.crossorigin {
    static func crossorigin(_ type: HTMLAttributeValue.CrossOrigin) -> Self {
        HTMLAttribute(name: "crossorigin", value: type.value)
    }
}

// integrity attribute
public extension HTMLTrait.Attributes {
    protocol integrity {}
}

extension HTMLTag.script: HTMLTrait.Attributes.integrity {}
extension HTMLTag.link: HTMLTrait.Attributes.integrity {}

public extension HTMLAttribute where Tag: HTMLTrait.Attributes.integrity {
    static func integrity(_ value: String) -> Self {
        HTMLAttribute(name: "integrity", value: value)
    }
}

// referrerpolicy attribute
public extension HTMLTrait.Attributes {
    protocol referrerpolicy {}
}

extension HTMLTag.script: HTMLTrait.Attributes.referrerpolicy {}
extension HTMLTag.link: HTMLTrait.Attributes.referrerpolicy {}

public extension HTMLAttributeValue {
    struct ReferrerPolicy: Sendable, Equatable {
        var value: String

        public static var noReferrer: Self { .init(value: "no-referrer") }
        public static var noReferrerWhenDowngrade: Self { .init(value: "no-referrer-when-downgrade") }
        public static var origin: Self { .init(value: "origin") }
        public static var originWhenCrossOrigin: Self { .init(value: "origin-when-cross-origin") }
        public static var sameOrigin: Self { .init(value: "same-origin") }
        public static var strictOrigin: Self { .init(value: "strict-origin") }
        public static var strictOriginWhenCrossOrigin: Self { .init(value: "strict-origin-when-cross-origin") }
        public static var unsafeUrl: Self { .init(value: "unsafe-url") }
    }
}

extension HTMLAttribute where Tag: HTMLTrait.Attributes.referrerpolicy {
    static func referrerPolicy(_ type: HTMLAttributeValue.ReferrerPolicy) -> Self {
        HTMLAttribute(name: "referrerpolicy", value: type.value)
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

    static func value(_ value: String) -> Self {
        HTMLAttribute(name: "value", value: value)
    }

    static var checked: Self {
        HTMLAttribute(name: "checked", value: nil)
    }
}

// label tag attributes
public extension HTMLAttribute where Tag == HTMLTag.label {
    static func `for`(_ id: String) -> Self {
        HTMLAttribute(name: "for", value: id)
    }
}

// option tag attributes
public extension HTMLAttribute where Tag == HTMLTag.option {
    static func value(_ value: String) -> Self {
        HTMLAttribute(name: "value", value: value)
    }

    static var selected: Self {
        HTMLAttribute(name: "selected", value: nil)
    }
}

// script tag attributes
public extension HTMLAttribute where Tag == HTMLTag.script {
    // type
    struct ScriptType: Sendable, ExpressibleByStringLiteral {
        var value: String

        init(value: String) {
            self.value = value
        }

        public init(stringLiteral value: String) {
            self.value = value
        }

        public static var importmap: Self { .init(value: "importmap") }
        public static var module: Self { .init(value: "module") }
        public static var speculationrules: Self { .init(value: "speculationrules") }
    }

    static func type(_ type: ScriptType) -> Self {
        HTMLAttribute(name: "type", value: type.value)
    }

    // async
    static var async: Self {
        HTMLAttribute(name: "async", value: nil)
    }

    // defer
    static var `defer`: Self {
        HTMLAttribute(name: "defer", value: nil)
    }

    // nomodule
    static var nomodule: Self {
        HTMLAttribute(name: "nomodule", value: nil)
    }
}
