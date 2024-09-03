@testable import GistKit

final class GistListCoordinatorSpy: GistListCoordinatorProtocol {
    enum Message: Equatable {
        case openFavorites
        case openDetails
        case showErrorAlert(message: String)
    }

    var receivedMessages = [Message]()

    func openFavorites() {
        receivedMessages.append(.openFavorites)
    }

    func openDetails(with data: [AnyHashable: Any]?) {
        receivedMessages.append(.openDetails)
    }

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
        retryAction()
    }
}
