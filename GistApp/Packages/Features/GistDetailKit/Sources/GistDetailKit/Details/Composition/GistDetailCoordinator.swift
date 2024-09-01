import UIKit
import RouterKit

protocol GistDetailCoordinatorProtocol { }

final class GistDetailCoordinator: GistDetailCoordinatorProtocol {
    private weak var navigator: UINavigationController?

    init(navigator: UINavigationController?) {
        self.navigator = navigator
    }

    func start(viewController: UIViewController) {
        navigator?.pushViewController(viewController, animated: true)
    }
}
