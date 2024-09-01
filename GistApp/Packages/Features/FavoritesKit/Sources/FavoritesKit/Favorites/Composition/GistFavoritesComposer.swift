import UIKit

public struct GistFavoritesComposer {
    public static func startScene(_ navigator: UINavigationController?) {
        let coordinator = GistFavoritesCoordinator(navigator: navigator)
        let viewModel = GistFavoritesViewModel(coordinator: coordinator)
        let viewController = GistFavoritesViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
