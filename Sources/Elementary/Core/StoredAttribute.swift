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
        case styles(StyleList)
        case classes(ClassList)
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
    static func styles(_ styles: StyleList) -> Self {
        .init(name: "style", value: nil, mergeMode: .appendValue(";"))
    }

    @usableFromInline
    static func classes(_ classes: ClassList) -> Self {
        .init(name: "class", value: nil, mergeMode: .appendValue(" "))
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
                existing.append(other.classes)
                _value = .classes(existing)
            case (.plain(let existing), .styles(let styles)):
                var newStyles = StyleList(plainValue: existing)
                newStyles.append(contentsOf: styles)
                _value = .styles(newStyles)
            case (.styles(var styles), .plain(let other)):
                styles.append(plainValue: other)
                _value = .styles(styles)
            case (.plain(let existing), .classes(let classes)):
                var newClasses = ClassList(arrayLiteral: existing)
                newClasses.append(classes.classes)
                _value = .classes(newClasses)
            case (.classes(var classes), .plain(let other)):
                classes.append([other])
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
    struct StyleList: Equatable, Sendable, ExpressibleByDictionaryLiteral {
        struct Entry: Equatable {
            let key: String
            let value: String
        }

        private var styles: [Entry]

        @usableFromInline
        init(dictionaryLiteral elements: (String, String)...) {
            self.styles = elements.map { Entry(key: $0.0, value: $0.1) }
        }

        @usableFromInline
        init(plainValue: String) {
            self.styles = [Entry(key: "", value: plainValue)]
        }

        mutating func append(plainValue: String) {
            styles.append(Entry(key: "", value: plainValue))
        }

        mutating func append(contentsOf other: StyleList) {
            styles.append(contentsOf: other.styles)
        }

        consuming func flatten() -> String {
            // TODO: make this more efficient
            var seen = Set<String>()
            return styles.filter { entry in
                if entry.key.isEmpty {
                    return true
                }
                return seen.insert(entry.key).inserted
            }.map { "\($0.key):\($0.value)" }.joined(separator: ";")
        }
    }

    @usableFromInline
    struct ClassList: Equatable, Sendable, ExpressibleByArrayLiteral {
        var classes: [String]

        @usableFromInline
        init(arrayLiteral elements: String...) {
            self.classes = elements
        }

        mutating func append(_ newClasses: [String]) {
            classes.append(contentsOf: newClasses)
        }

        consuming func flatten() -> String {
            var seen = Set<String>()
            return classes.filter { seen.insert($0).inserted }.joined(separator: " ")
        }
    }
}
