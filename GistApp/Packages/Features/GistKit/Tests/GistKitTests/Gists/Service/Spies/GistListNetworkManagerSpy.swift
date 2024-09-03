import NetworkKit
@testable import GistKit

final class GistListNetworkManagerSpy: NetworkManagerProtocol {
    var completionPassed: ((GistListResult) -> Void)?
    var result: ResponseResult?

    enum Message: Equatable {
        case request(result: GistListResult)
    }

    var receivedMessages = [Message]()

    func completeWithSuccess(result: GistListResult) {
        completionPassed?(result)
    }

    func completeWithError(error: ResponseError) {
        completionPassed?(.failure(error))
    }

    func request(with config: NetworkKit.RequestConfigProtocol, completion: @escaping (ResponseResult) -> Void) {
        completionPassed = { [weak self] response in
            self?.receivedMessages.append(.request(result: response))
        }
        completion(result!)
    }
}
