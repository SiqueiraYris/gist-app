import UIKit
import CommonKit

public struct GistDetailComposer {
    public static func startScene(
        _ navigator: UINavigationController?,
        with data: [AnyHashable: Any]?
    ) {
        guard let dataSource = data?.toModel(GistDetailDataSource.self) else { return }
        let coordinator = GistDetailCoordinator(navigator: navigator)
        let viewModel = GistDetailViewModel(
            coordinator: coordinator, 
            dataSource: dataSource
        )
        let viewController = GistDetailViewController(viewModel: viewModel)

        coordinator.start(viewController: viewController)
    }
}
