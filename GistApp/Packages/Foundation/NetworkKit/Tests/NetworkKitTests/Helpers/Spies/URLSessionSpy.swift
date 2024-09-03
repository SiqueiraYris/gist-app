import Foundation
import NetworkKit

final class URLSessionSpy: URLSessionProtocol {
    enum Messages: Equatable {
        case dataTask(request: URLRequest)
    }

    var receivedMessages: [Messages] = []
    var configuration: URLSessionConfiguration = .default
    var dataToBeReturned: Data?
    var responseToBeReturned: URLResponse?
    var errorToBeReturned: Error?

    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        receivedMessages.append(.dataTask(request: request))
        let task = URLSessionDataTaskSpy { [weak self] in
            completionHandler(
                self?.dataToBeReturned,
                self?.responseToBeReturned,
                self?.errorToBeReturned
            )
        }
        return task
    }
}
