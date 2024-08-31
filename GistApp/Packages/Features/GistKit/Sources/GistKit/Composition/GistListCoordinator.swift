import UIKit

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
        
    }
}
