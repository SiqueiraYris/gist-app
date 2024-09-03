@testable import FavoritesKit

final class GistFavoritesCoordinatorSpy: GistFavoritesCoordinatorProtocol {
    enum Message: Equatable {
        case showErrorAlert(message: String)
        case showClearConfirmationAlert
        case back
        case openDetails
    }

    var receivedMessages = [Message]()

    var confirmationToBeReturned = false

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        receivedMessages.append(.showErrorAlert(message: message))
        retryAction()
    }

    func showClearConfirmationAlert(completion: @escaping (Bool) -> Void) {
        receivedMessages.append(.showClearConfirmationAlert)
        completion(confirmationToBeReturned)
    }

    func back() {
        receivedMessages.append(.back)
    }

    func openDetails(with data: [AnyHashable: Any]?) {
        receivedMessages.append(.openDetails)
    }
}
