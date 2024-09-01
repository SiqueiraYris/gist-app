import Foundation

public struct ResponseError: LocalizedError, Equatable {
    var message: String
    public var errorCode: String?
    public var code: Int?
    public var errorDescription: String? {
        return message
    }

    public init(statusCode: Int? = nil, defaultError: NetworkError.HTTPErrors = .badRequest) {
        self.code = statusCode
        self.message = defaultError.errorDescription ?? defaultError.localizedDescription
    }

    public init(statusCode: Int? = nil, defaultError: NetworkError = .unknownFailure) {
        self.code = statusCode
        self.message = defaultError.errorDescription ?? defaultError.localizedDescription
    }

    public init(statusCode: Int? = nil, defaultError: NetworkErrorProtocol) {
        self.code = statusCode
        self.message = defaultError.errorDescription ?? ""
    }
}
