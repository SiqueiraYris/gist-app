import Foundation

struct ResponseMapper {
    static func map(_ nsError: NSError) throws {
        switch nsError.code {
        case NetworkError.decoderFailure.code:
            throw NetworkError.decoderFailure

        case NetworkError.malformedUrl.code:
            throw NetworkError.malformedUrl

        case NetworkError.noData.code:
            throw NetworkError.noData

        case NetworkError.connectionLost.code:
            throw NetworkError.connectionLost

        case NetworkError.unknownFailure.code:
            throw NetworkError.unknownFailure

        case NetworkError.notConnected.code:
            throw NetworkError.notConnected

        default:
            throw NetworkError.requestFailure
        }
    }

    static func map(_ statusCode: Int) throws {
        switch statusCode {
        case 200...299:
            break

        case 400:
            throw NetworkError.HTTPErrors.badRequest

        case 401:
            throw NetworkError.HTTPErrors.unauthorized

        case 403:
            throw NetworkError.HTTPErrors.forbidden

        case 404:
            throw NetworkError.HTTPErrors.notFound

        case 408:
            throw NetworkError.HTTPErrors.timeOut

        case 422:
            throw NetworkError.HTTPErrors.unprocessableEntity

        case 500:
            throw NetworkError.HTTPErrors.internalServerError

        default:
            throw NetworkError.decoderFailure
        }
    }
}
