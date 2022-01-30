public struct WeakArc<T> {
    private weak var inner: ArcInnerWrapper<T>?
    
    public var value: T? {
        inner?.value
    }
    
    init(_ wrapper: ArcInnerWrapper<T>) {
        self.inner = wrapper
    }
}

// MARK: - Dereference

prefix operator *
prefix func * <T>(x: WeakArc<T>) -> T? {
    return x.value
}

// MARK: - Protocols in std

extension WeakArc: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.value.debugDescription
    }
}

extension WeakArc: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        return self.value?.description ?? "nil"
    }
}

extension WeakArc: CustomReflectable where T: CustomReflectable {
    public var customMirror: Mirror {
        return self.value.customMirror
    }
}

extension WeakArc: CustomPlaygroundDisplayConvertible where T: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return self.value?.playgroundDescription as Any
    }
}

extension WeakArc: Decodable where T: Decodable {}

extension WeakArc: Encodable where T: Encodable {}

extension WeakArc: Equatable where T: Equatable {
    public static func == (lhs: WeakArc<T>, rhs: WeakArc<T>) -> Bool {
        lhs.value == rhs.value
    }
}

extension WeakArc: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.value.hash(into: &hasher)
    }
}
