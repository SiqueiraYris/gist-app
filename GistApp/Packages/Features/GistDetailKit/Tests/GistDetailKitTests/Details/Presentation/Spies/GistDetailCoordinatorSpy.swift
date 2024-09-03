@testable import GistDetailKit

final class GistDetailCoordinatorSpy: GistDetailCoordinatorProtocol {
    enum Message: Equatable {
        case showErrorAlert(message: String)
    }

    var receivedMessages = [Message]()

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
//        retryAction()
    }
}
