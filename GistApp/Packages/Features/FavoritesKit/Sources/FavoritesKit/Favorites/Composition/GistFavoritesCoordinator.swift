import UIKit
import RouterKit

protocol GistFavoritesCoordinatorProtocol { }

final class GistFavoritesCoordinator: GistFavoritesCoordinatorProtocol {
    private weak var navigator: UINavigationController?

    init(navigator: UINavigationController?) {
        self.navigator = navigator
    }

    func start(viewController: UIViewController) {
        navigator?.pushViewController(viewController, animated: true)
    }
}
