import UIKit
import RouterKit

protocol GistFavoritesCoordinatorProtocol {
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
    func showClearConfirmationAlert(completion: @escaping (Bool) -> Void)
    func back()
    func openDetails(with data: [AnyHashable: Any]?)
}

final class GistFavoritesCoordinator: GistFavoritesCoordinatorProtocol {
    // MARK: - Properties
    
    private weak var navigator: UINavigationController?
    private let router: RoutingHubProtocol

    // MARK: - Initializer
    
    init(navigator: UINavigationController?, router: RoutingHubProtocol) {
        self.navigator = navigator
        self.router = router
    }

    // MARK: - Methods

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

    func back() {
        navigator?.popViewController(animated: true)
    }

    func openDetails(with data: [AnyHashable: Any]?) {
        if let url = URL(string: "gist-app://gist-detail") {
            router.start(url: url, on: navigator, with: data)
        }
    }
}
