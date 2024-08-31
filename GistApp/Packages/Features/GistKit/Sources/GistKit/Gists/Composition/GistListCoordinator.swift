import UIKit
import RouterKit

protocol GistListCoordinatorProtocol {
    func openFavorites()
}

final class GistListCoordinator: GistListCoordinatorProtocol {
    private weak var navigator: UINavigationController?

    init(navigator: UINavigationController?) {
        self.navigator = navigator
    }

    func start(viewController: UIViewController) {
        navigator?.pushViewController(viewController, animated: true)
    }

    func openFavorites() {
        if let url = URL(string: "gist-app://favorites") {
            RoutingHub.shared.start(url: url, on: navigator)
        }
    }
}
