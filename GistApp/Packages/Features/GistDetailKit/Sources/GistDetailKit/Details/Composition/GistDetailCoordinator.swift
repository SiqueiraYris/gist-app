import UIKit
import RouterKit

protocol GistDetailCoordinatorProtocol {
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
}

final class GistDetailCoordinator: GistDetailCoordinatorProtocol {
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
}
