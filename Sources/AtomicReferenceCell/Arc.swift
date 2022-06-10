public struct Arc<T> {
    let inner: ArcInnerWrapper<T>
    
    public var deref: T {
        inner.value
    }
    
    public init(_ value: T) {
        self.inner = ArcInnerWrapper(value)
    }
}

// MARK: - Weak reference

extension Arc {
    func weak() -> WeakArc<T> {
        return WeakArc(self.inner)
    }
}

// MARK: - Dereference

prefix operator *
prefix func * <T>(x: Arc<T>) -> T {
    return x.deref
}

// MARK: - Functor & Monad

extension Arc {
    public func map<U>(_ f: (T) -> U) -> Arc<U> {
        return Arc<U>(f(self.deref))
    }
    
    public func flatMap<U>(_ f: (T) -> Arc<U>) -> Arc<U> {
        return f(self.deref)
    }
}

// MARK: - Protocols in std

extension Arc: CustomDebugStringConvertible where T: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.deref.debugDescription
    }
}

extension Arc: CustomStringConvertible where T: CustomStringConvertible {
    public var description: String {
        return self.deref.description
    }
}

extension Arc: CustomReflectable where T: CustomReflectable {
    public var customMirror: Mirror {
        return self.deref.customMirror
    }
}

extension Arc: CustomPlaygroundDisplayConvertible where T: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        return self.deref.playgroundDescription
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Arc: Identifiable where T: Identifiable {
    public typealias ID = T.ID
    
    public var id: Self.ID {
        return self.deref.id
    }
}

extension Arc: Decodable where T: Decodable {}

extension Arc: Encodable where T: Encodable {}

extension Arc: Equatable where T: Equatable {
    public static func == (lhs: Arc<T>, rhs: Arc<T>) -> Bool {
        lhs.deref == rhs.deref
    }
}

extension Arc: Comparable where T: Comparable {
    public static func < (lhs: Arc<T>, rhs: Arc<T>) -> Bool {
        return lhs.deref < rhs.deref
    }
}

extension Arc: Hashable where T: Hashable {    
    public func hash(into hasher: inout Hasher) {
        self.deref.hash(into: &hasher)
    }
}

