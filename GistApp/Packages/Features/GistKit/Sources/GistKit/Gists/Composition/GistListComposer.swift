import UIKit
import NetworkKit
import RouterKit

public struct GistListComposer {
    public static func startScene(_ navigator: UINavigationController?) {
        let coordinator = GistListCoordinator(
            navigator: navigator, 
            router: RoutingHub.shared
        )
        let service = GistListService(manager: NetworkManager.shared)
        let viewModel = GistListViewModel(coordinator: coordinator, service: service)
        let viewController = GistListViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
