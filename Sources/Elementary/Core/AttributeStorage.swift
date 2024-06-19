// add enough tags and attributes for an example
// finalize name and push to github
struct StoredAttribute: Equatable {
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

enum AttributeStorage {
    case none
    case single(StoredAttribute)
    case multiple([StoredAttribute])

    init() {
        self = .none
    }

    init(_ attribute: HtmlAttribute<some HtmlTagDefinition>) {
        self = .single(attribute.htmlAttribute)
    }

    init(_ attributes: [HtmlAttribute<some HtmlTagDefinition>]) {
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

    consuming func flattened() -> [StoredAttribute] {
        // NOTE: maybe return a fancy sequence instead so we can iterate over it and avoid array allocations
        switch self {
        case .none: return []
        case let .single(attribute): return [attribute]
        case let .multiple(attributes): return flattenAttributes(attributes)
        }
    }
}

private func flattenAttributes(_ attributes: consuming [StoredAttribute]) -> [StoredAttribute] {
    let blankedOut = StoredAttribute(name: "")
    var result: [StoredAttribute] = []

    for i in attributes.indices {
        var attribute = attributes[i]
        guard attribute != blankedOut else { continue }

        for j in attributes.indices[(i + 1)...] where attributes[j].name == attribute.name {
            switch attribute.mergeMode {
            case let .appendValue(separator):
                attribute.appending(value: attributes[j].value, separatedBy: separator)
            case .replaceValue:
                attribute.value = attributes[j].value
            case .ignoreIfSet:
                break
            }
            attributes[j] = blankedOut
        }

        result.append(attribute)
    }

    return result
}
