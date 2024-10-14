public struct _StoredAttribute: Equatable, Sendable {
    @usableFromInline
    enum MergeMode: Equatable, Sendable {
        case appendValue(_ separator: String = " ")
        case replaceValue
        case ignoreIfSet
    }

    public var name: String
    public var value: String?
    @usableFromInline
    var mergeMode: MergeMode = .replaceValue

    @usableFromInline
    init(name: String, value: String? = nil, mergeMode: MergeMode = .replaceValue) {
        self.name = name
        self.value = value
        self.mergeMode = mergeMode
    }

    mutating func mergeWith(_ attribute: consuming _StoredAttribute) {
        switch attribute.mergeMode {
        case let .appendValue(separator):
            value = switch (value, attribute.value) {
            case (_, .none): value
            case let (.none, .some(value)): value
            case let (.some(existingValue), .some(otherValue)): "\(existingValue)\(separator)\(otherValue)"
            }
        case .replaceValue:
            value = attribute.value
        case .ignoreIfSet:
            break
        }
    }
}

public enum _AttributeStorage: Sendable, Equatable {
    case none
    case single(_StoredAttribute)
    case multiple([_StoredAttribute])

    @inlinable
    init() {
        self = .none
    }

    @inlinable
    init(_ attribute: HTMLAttribute<some HTMLTagDefinition>) {
        self = .single(attribute.htmlAttribute)
    }

    @inlinable
    init(_ attributes: [HTMLAttribute<some HTMLTagDefinition>]) {
        switch attributes.count {
        case 0: self = .none
        case 1: self = .single(attributes[0].htmlAttribute)
        default: self = .multiple(attributes.map { $0.htmlAttribute })
        }
    }

    public var isEmpty: Bool {
        switch self {
        case .none: return true
        case .single: return false
        case let .multiple(attributes): return attributes.isEmpty // just to be sure...
        }
    }

    public mutating func append(_ attributes: consuming _AttributeStorage) {
        // maybe this was a bad idea....
        switch (self, attributes) {
        case (_, .none):
            break
        case let (.none, other):
            self = other
        case let (.single(existing), .single(other)):
            self = .multiple([existing, other])
        case (let .single(existing), var .multiple(others)):
            others.insert(existing, at: 0)
            self = .multiple(others)
        case (var .multiple(existing), let .single(other)):
            existing.append(other)
            self = .multiple(existing)
        case (var .multiple(existing), let .multiple(others)):
            existing.append(contentsOf: others)
            self = .multiple(existing)
        }
    }

    public consuming func flattened() -> _MergedAttributes {
        .init(storage: self)
    }
}

public struct _MergedAttributes: Sequence, Sendable {
    public typealias Element = _StoredAttribute
    var storage: _AttributeStorage

    public consuming func makeIterator() -> Iterator {
        Iterator(storage)
    }

    public var isEmpty: Bool {
        storage.isEmpty
    }

    public struct Iterator: IteratorProtocol {
        enum State {
            case empty
            case single(_StoredAttribute)
            case flattening([_StoredAttribute], Int)
            case _temporaryNothing
        }

        var state: State

        init(_ storage: consuming _AttributeStorage) {
            switch storage {
            case .none: state = .empty
            case let .single(attribute): state = .single(attribute)
            case let .multiple(attributes): state = .flattening(attributes, 0)
            }
        }

        public mutating func next() -> _StoredAttribute? {
            switch state {
            case .empty: return nil
            case let .single(attribute):
                state = .empty
                return attribute
            case .flattening(var list, let index):
                state = ._temporaryNothing
                let (attribute, newIndex) = nextflattenedAttribute(attributes: &list, from: index)

                if let newIndex {
                    state = .flattening(list, newIndex)
                } else {
                    state = .empty
                }

                return attribute
            case ._temporaryNothing:
                fatalError("unexpected _temporaryNothing state")
            }
        }
    }
}

private func nextflattenedAttribute(attributes: inout [_StoredAttribute], from index: Int) -> (_StoredAttribute, Int?) {
    var attribute: _StoredAttribute = .blankedOut
    swap(&attribute, &attributes[index])

    var nextIndex: Int?

    for j in attributes.indices[(index + 1)...] {
        // fast-skip blanked out attributes
        guard !attributes[j].name.isEmpty else { continue }

        guard attributes[j].name.utf8Equals(attribute.name) else {
            if nextIndex == nil { nextIndex = j }
            continue
        }

        var mergedAttribute: _StoredAttribute = .blankedOut
        swap(&mergedAttribute, &attributes[j])

        attribute.mergeWith(mergedAttribute)
    }

    return (attribute, nextIndex)
}

private extension _StoredAttribute {
    static let blankedOut = _StoredAttribute(name: "")
}

private extension String {
    @inline(__always)
    func utf8Equals(_ other: borrowing String) -> Bool {
        // for embedded support
        utf8.elementsEqual(other.utf8)
    }
}
