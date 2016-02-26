#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

public class Data {
    
    public let bytes: UnsafeMutablePointer<Int8>

    public let capacity: Int
    
    public init(capacity: Int) {
        bytes = UnsafeMutablePointer<Int8>(malloc(capacity + 1))
        self.capacity = capacity
    }
    
    deinit {
        free(bytes)
    }
    
    public var characters: [CChar] {
        var data = [CChar](count: capacity, repeatedValue: 0)
        memcpy(&data, bytes, data.count)
        return data
    }
    
    public var string: String? {
        return String.fromCString(bytes)
    }
}
