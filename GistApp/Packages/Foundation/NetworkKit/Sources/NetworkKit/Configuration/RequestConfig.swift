import Foundation

public struct RequestConfig: RequestConfigProtocol {
    public var scheme: String
    public var host: String
    public var path: String
    public var method: HTTPMethod
    public var parameters: [String: Any]
    public var headers: [String: String]
    public var parametersEncoding: ParameterEncoding
    public var debugMode: Bool

    public init(scheme: String = Constants.scheme,
                host: String = Constants.serverHost,
                path: String,
                method: HTTPMethod = .get,
                encoding: ParameterEncoding = .url,
                parameters: [String: Any] = [:],
                headers: [String: String] = [:],
                debugMode: Bool = false) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.parametersEncoding = encoding
        self.debugMode = debugMode
    }
}
