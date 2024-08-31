import UIKit
import NetworkKit

public struct GistListComposer {
    public static func startScene(_ navigator: UINavigationController?) {
        let coordinator = GistListCoordinator(navigator: navigator)
        let service = GistListService(manager: NetworkManager.shared)
        let viewModel = GistListViewModel(coordinator: coordinator, service: service)
        let viewController = GistListViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
