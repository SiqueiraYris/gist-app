import UIKit
import DatabaseKit
import RouterKit

public struct GistFavoritesComposer {
    public static func startScene(_ navigator: UINavigationController?) {
        let coordinator = GistFavoritesCoordinator(navigator: navigator, router: RoutingHub.shared)
        let storage = GistFavoritesStorageProvider(storageManager: DatabaseManager.shared)
        let viewModel = GistFavoritesViewModel(coordinator: coordinator, storage: storage)
        let viewController = GistFavoritesViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
