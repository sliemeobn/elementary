/// An internal type representing a type-erased HTML attribute.
///
/// This type is used to store HTML attributes and their values of an element. It supports different types of values
/// like plain strings, styles, and classes, and provides different merge strategies when combining attributes.
///
/// The merge strategies control how attributes with the same name are combined:
/// - `.appendValue`: Appends values with a separator (default is space)
/// - `.replaceValue`: Replaces any existing value
/// - `.ignoreIfSet`: Keeps the existing value if present
public struct _StoredAttribute: Equatable, Sendable {
    @usableFromInline
    enum MergeMode: Equatable, Sendable {
        case appendValue(_ separator: String = " ")
        case replaceValue
        case ignoreIfSet
    }

    enum Value: Equatable {
        case empty
        case plain(String)
        case styles(Styles)
        case classes(Classes)
    }

    public var name: String
    var _value: Value

    // NOTE: this is mainly here to not break API for now
    public var value: String? {
        get {
            switch _value {
            case .empty: return nil
            case let .plain(value): return value
            case let .styles(styles): return styles.flatten()
            case let .classes(classes): return classes.flatten()
            }
        }
        set {
            _value = newValue.map { .plain($0) } ?? .empty
        }
    }

    @usableFromInline
    var mergeMode: MergeMode = .replaceValue

    @usableFromInline
    init(name: String, value: String? = nil, mergeMode: MergeMode = .replaceValue) {
        self.name = name
        self._value = value.map { .plain($0) } ?? .empty
        self.mergeMode = mergeMode
    }

    @usableFromInline
    init(_ styles: Styles) {
        self.name = "style"
        self._value = .styles(styles)
        self.mergeMode = .appendValue(";")
    }

    @usableFromInline
    init(_ classes: Classes) {
        self.name = "class"
        self._value = .classes(classes)
        self.mergeMode = .appendValue(" ")
    }

    mutating func mergeWith(_ attribute: consuming _StoredAttribute) {
        switch attribute.mergeMode {
        case let .appendValue(separator):
            switch (_value, attribute._value) {
            case (_, .empty):
                break
            case (.empty, let other):
                _value = other
            case (.plain(let existing), .plain(let other)):
                _value = .plain("\(existing)\(separator)\(other)")
            case (.styles(var existing), .styles(let other)):
                existing.append(contentsOf: other)
                _value = .styles(existing)
            case (.classes(var existing), .classes(let other)):
                existing.append(contentsOf: other)
                _value = .classes(existing)
            case (.plain(let existing), .styles(let styles)):
                var newStyles = Styles(plainValue: existing)
                newStyles.append(contentsOf: styles)
                _value = .styles(newStyles)
            case (.styles(var styles), .plain(let other)):
                styles.append(plainValue: other)
                _value = .styles(styles)
            case (.plain(let existing), .classes(let classes)):
                var newClasses = Classes([existing])
                newClasses.append(contentsOf: classes)
                _value = .classes(newClasses)
            case (.classes(var classes), .plain(let other)):
                classes.append(plainValue: other)
                _value = .classes(classes)
            case (.styles, .classes), (.classes, .styles):
                assertionFailure("Cannot merge styles and classes")
                // If trying to merge incompatible types, just replace
                _value = attribute._value
            }
        case .replaceValue:
            _value = attribute._value
        case .ignoreIfSet:
            break
        }
    }
}

extension _StoredAttribute {
    @usableFromInline
    struct Styles: Equatable, Sendable {
        @usableFromInline
        struct Entry: Equatable, Sendable {
            let key: String
            let value: String

            @usableFromInline
            init(key: String, value: String) {
                self.key = key
                self.value = value
            }
        }

        @usableFromInline
        var styles: [Entry]

        @inlinable
        init(_ elements: some Sequence<(key: String, value: String)>) {
            self.styles = elements.map { Entry(key: $0.0, value: $0.1) }
        }

        @usableFromInline
        init(plainValue: String) {
            self.styles = [Entry(key: "", value: plainValue)]
        }

        mutating func append(plainValue: String) {
            styles.append(Entry(key: "", value: plainValue))
        }

        mutating func append(contentsOf other: consuming Styles) {
            let originalCount = styles.count
            for entry in other.styles {
                if entry.key.isEmpty {
                    styles.append(entry)
                } else {
                    for i in 0..<originalCount {
                        if styles[i].key.utf8Equals(entry.key) {
                            styles.remove(at: i)
                            break
                        }
                    }
                    styles.append(entry)
                }
            }
        }

        consuming func flatten() -> String {
            var result = ""
            for (index, entry) in styles.enumerated() {
                if index > 0 {
                    result += ";"
                }
                if entry.key.isEmpty {
                    result += entry.value
                } else {
                    result += "\(entry.key):\(entry.value)"
                }
            }
            return result
        }
    }

    @usableFromInline
    struct Classes: Equatable, Sendable {
        @usableFromInline
        var classes: [String]

        @inlinable
        init(_ elements: [String]) {
            self.classes = elements
        }

        @inlinable
        init(_ elements: some Sequence<String>) {
            self.classes = Array(elements)
        }

        mutating func append(plainValue newClass: String) {
            classes.append(newClass)
        }

        mutating func append(contentsOf other: consuming Classes) {
            let originalCount = classes.count
            for newClass in other.classes {
                if !classes.prefix(originalCount).contains(where: { $0.utf8Equals(newClass) }) {
                    classes.append(newClass)
                }
            }
        }

        consuming func flatten() -> String {
            classes.joined(separator: " ")
        }
    }
}

extension String {
   
    fileprivate func utf8Equals(_ other: borrowing String) -> Bool {
        // for embedded support
        utf8.elementsEqual(other.utf8)
    }
}
