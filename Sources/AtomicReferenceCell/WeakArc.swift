public struct WeakArc<T> {
    weak var inner: ArcInnerWrapper<T>?
    
    public var deref: T? {
        inner?.value
    }
    
    init(_ wrapper: ArcInnerWrapper<T>) {
        self.inner = wrapper
    }
}

// MARK: - Dereference

prefix operator *
prefix func * <T>(x: WeakArc<T>) -> T? {
    return x.deref
}

// MARK: - Protocols in std

extension WeakArc: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.deref.debugDescription
    }
}

extension WeakArc: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        return self.deref?.description ?? "nil"
    }
}

extension WeakArc: CustomReflectable where T: CustomReflectable {
    public var customMirror: Mirror {
        return self.deref.customMirror
    }
}

extension WeakArc: CustomPlaygroundDisplayConvertible where T: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return self.deref?.playgroundDescription as Any
    }
}

extension WeakArc: Decodable where T: Decodable {}

extension WeakArc: Encodable where T: Encodable {}

extension WeakArc: Equatable where T: Equatable {
    public static func == (lhs: WeakArc<T>, rhs: WeakArc<T>) -> Bool {
        lhs.deref == rhs.deref
    }
}

extension WeakArc: Hashable where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.deref.hash(into: &hasher)
    }
}
