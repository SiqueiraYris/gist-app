import Foundation
import NetworkKit

extension ResponseError {
    static func fixture(statusCode: Int = 500,
                        defaultError: NetworkError.HTTPErrors = .internalServerError) -> ResponseError {
        return ResponseError(statusCode: statusCode,
                             defaultError: defaultError)
    }
}
