import UIKit
import CommonKit
import NetworkKit
import DatabaseKit

public struct GistDetailComposer {
    public static func startScene(
        _ navigator: UINavigationController?,
        with data: [AnyHashable: Any]?
    ) {
        guard let dataSource = data?.toModel(GistDetailDataSource.self) else { return }
        let coordinator = GistDetailCoordinator(navigator: navigator)
        let storageProvider = GistDetailStorageProvider(storageManager: DatabaseManager.shared)
        let service = GistDetailService(manager: NetworkManager.shared)
        let viewModel = GistDetailViewModel(
            coordinator: coordinator,
            service: service,
            storageProvider: storageProvider,
            dataSource: dataSource
        )
        let viewController = GistDetailViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
