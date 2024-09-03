import NetworkKit
@testable import GistDetailKit

final class NetworkManagerSpy: NetworkManagerProtocol {
    var completionPassed: ((GistDetailResult) -> Void)?
    var result: ResponseResult?

    enum Message: Equatable {
        case request(result: GistDetailResult)
    }

    var receivedMessages = [Message]()

    func completeWithSuccess(result: GistDetailResult) {
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
