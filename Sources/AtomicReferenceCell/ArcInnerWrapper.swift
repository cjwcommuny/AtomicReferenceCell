final class ArcInnerWrapper<T> {
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}

extension ArcInnerWrapper: Decodable where T: Decodable {}

extension ArcInnerWrapper: Encodable where T: Encodable {}
