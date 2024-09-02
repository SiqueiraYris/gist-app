import UIKit
import DatabaseKit

public struct GistFavoritesComposer {
    public static func startScene(_ navigator: UINavigationController?) {
        let coordinator = GistFavoritesCoordinator(navigator: navigator)
        let storage = GistFavoritesStorageProvider(storageManager: StorageManager.shared)
        let viewModel = GistFavoritesViewModel(coordinator: coordinator, storage: storage)
        let viewController = GistFavoritesViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
