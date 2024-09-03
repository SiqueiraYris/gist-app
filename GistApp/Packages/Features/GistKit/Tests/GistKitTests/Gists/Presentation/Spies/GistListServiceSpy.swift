import NetworkKit
@testable import GistKit

final class GistListServiceSpy: GistListServiceProtocol {
    enum Message: Equatable {
        case fetch(route: GistListServiceRoute)
    }

    var receivedMessages = [Message]()

    var completionPassed: ((GistListResult) -> Void)?
    var result: GistListResult?

    func fetch(
        _ route: GistListServiceRoute,
        completion: @escaping(GistListResult) -> Void
    ) {
        receivedMessages.append(.fetch(route: route))
        completion(result!)
    }

    func completeWithSuccess(object: [GistItemResponse]) {
        completionPassed?(.success(object))
    }

    func completeWithError(error: ResponseError) {
        completionPassed?(.failure(error))
    }
}
