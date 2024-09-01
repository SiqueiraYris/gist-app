public protocol NetworkErrorProtocol {
    var code: Int { get }
    var errorDescription: String? { get }
}
