import UIKit
import RouterKit

protocol GistListCoordinatorProtocol {
    func openFavorites()
    func openDetails(with data: [AnyHashable: Any]?)
    func showErrorAlert(with message: String, retryAction: @escaping () -> Void)
}

final class GistListCoordinator: GistListCoordinatorProtocol {
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

    func openFavorites() {
        if let url = URL(string: "gist-app://favorites") {
            router.start(url: url, on: navigator, with: nil)
        }
    }

    func openDetails(with data: [AnyHashable: Any]?) {
        if let url = URL(string: "gist-app://gist-detail") {
            router.start(url: url, on: navigator, with: data)
        }
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
