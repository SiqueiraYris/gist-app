import UIKit
import RouterKit

protocol GistFavoritesCoordinatorProtocol {
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
    func showClearConfirmationAlert(completion: @escaping (Bool) -> Void)
}

final class GistFavoritesCoordinator: GistFavoritesCoordinatorProtocol {
    private weak var navigator: UINavigationController?

    init(navigator: UINavigationController?) {
        self.navigator = navigator
    }

    func start(viewController: UIViewController) {
        navigator?.pushViewController(viewController, animated: true)
    }

    func showErrorAlert(with message: String, retryAction: @escaping () -> Void) {
        let alert = UIAlertController(
            title: Strings.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: Strings.errorRepeatButtonTitle,
            style: .default
        ) { _ in
            retryAction()
        })
        alert.addAction(UIAlertAction(
            title: Strings.errorCloseButtonTitle,
            style: .cancel
        ))

        navigator?.present(alert, animated: true, completion: nil)
    }

    func showClearConfirmationAlert(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: Strings.clearConfirmationTitle,
            message: Strings.clearConfirmationMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: Strings.clearConfirmationButtonTitle,
            style: .destructive
        ) { _ in
            completion(true)
        })

        alert.addAction(UIAlertAction(
            title: Strings.clearCancelButtonTitle,
            style: .cancel
        ) { _ in
            completion(false)
        })

        navigator?.present(alert, animated: true, completion: nil)
    }
}
