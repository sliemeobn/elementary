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

public extension HtmlAttribute where Tag == HtmlTag.a {
    static func href(_ value: String) -> Self {
        HtmlAttribute(name: "href", value: value)
    }
}

public extension HtmlAttribute where Tag == HtmlTag.img {
    static func src(_ value: String) -> Self {
        HtmlAttribute(name: "src", value: value)
    }
}
