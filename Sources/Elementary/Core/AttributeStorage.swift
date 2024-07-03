struct StoredAttribute: Equatable, Sendable {
    enum MergeMode: Equatable {
        case appendValue(_ separator: String = " ")
        case replaceValue
        case ignoreIfSet
    }

    var name: String
    var value: String?
    var mergeMode: MergeMode = .replaceValue

    mutating func appending(value: String?, separatedBy separator: String) {
        self.value = switch (self.value, value) {
        case (_, .none): self.value
        case let (.none, .some(value)): value
        case let (.some(existingValue), .some(otherValue)): "\(existingValue)\(separator)\(otherValue)"
        }
    }
}

enum AttributeStorage: Sendable {
    case none
    case single(StoredAttribute)
    case multiple([StoredAttribute])

    init() {
        self = .none
    }

    init(_ attribute: HTMLAttribute<some HTMLTagDefinition>) {
        self = .single(attribute.htmlAttribute)
    }

    init(_ attributes: [HTMLAttribute<some HTMLTagDefinition>]) {
        switch attributes.count {
        case 0: self = .none
        case 1: self = .single(attributes[0].htmlAttribute)
        default: self = .multiple(attributes.map { $0.htmlAttribute })
        }
    }

    var isEmpty: Bool {
        switch self {
        case .none: return true
        case .single: return false
        case let .multiple(attributes): return attributes.isEmpty // just to be sure...
        }
    }

    mutating func append(_ attributes: consuming AttributeStorage) {
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

    consuming func flattened() -> FlattenedAttributeView {
        .init(storage: self)
    }
}

extension AttributeStorage {
    struct FlattenedAttributeView: Sequence, Sendable {
        typealias Element = StoredAttribute
        var storage: AttributeStorage

        consuming func makeIterator() -> Iterator {
            Iterator(storage)
        }

        struct Iterator: IteratorProtocol {
            enum State {
                case empty
                case single(StoredAttribute)
                case flattening([StoredAttribute], Int)
                case _temporaryNothing
            }

            var state: State

            init(_ storage: consuming AttributeStorage) {
                switch storage {
                case .none: state = .empty
                case let .single(attribute): state = .single(attribute)
                case let .multiple(attributes): state = .flattening(attributes, 0)
                }
            }

            mutating func next() -> StoredAttribute? {
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
}

private let blankedOut = StoredAttribute(name: "")
private func nextflattenedAttribute(attributes: inout [StoredAttribute], from index: Int) -> (StoredAttribute, Int?) {
    var attribute = attributes[index]
    attributes[index] = blankedOut

    var nextIndex: Int?

    for j in attributes.indices[(index + 1)...] {
        // fast-skip blanked out attributes
        guard !attributes[j].name.isEmpty else { continue }

        guard attributes[j].name == attribute.name else {
            if nextIndex == nil { nextIndex = j }
            continue
        }

        switch attributes[j].mergeMode {
        case let .appendValue(separator):
            attribute.appending(value: attributes[j].value, separatedBy: separator)
        case .replaceValue:
            attribute.value = attributes[j].value
        case .ignoreIfSet:
            break
        }
        attributes[j] = blankedOut
    }

    return (attribute, nextIndex)
}
