import Foundation
import NetworkKit
@testable import GistDetailKit

final class GistDetailServiceSpy: GistDetailServiceProtocol {
    enum Message: Equatable {
        case downloadImage(from: String)
        case fetch(route: GistDetailServiceRoute)
    }

    var receivedMessages = [Message]()

    var completionPassed: ((GistDetailResult) -> Void)?
    var result: GistDetailResult?
    var downloadImageResult: Data?

    func downloadImage(from url: String, completion: @escaping (Data?) -> Void) {
        receivedMessages.append(.downloadImage(from: url))
        completion(downloadImageResult)
    }

    func fetch(_ route: GistDetailServiceRoute, completion: @escaping (GistDetailResult) -> Void) {
        receivedMessages.append(.fetch(route: route))
        completion(result!)
    }

    func completeWithSuccess(object: String) {
        completionPassed?(.success(object))
    }

    func completeWithError(error: ResponseError) {
        completionPassed?(.failure(error))
    }
}
