import UIKit
import RouterKit

final class AppStarter {
    private let navigation = UINavigationController()
    private let routingHub = RoutingHub.shared

    static var shared = AppStarter()

    func start(window: UIWindow?) {
        startApp(window: window)
        setupRoutingHub(window: window)
    }

    private func startApp(window: UIWindow?) {
        let navigation = UINavigationController()

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    private func setupRoutingHub(window: UIWindow?) {
        let descriptorsManager = DescriptorsManager(routingHub: routingHub)
        descriptorsManager.setup()

        window?.rootViewController = navigation

        if let url = URL(string: "gist-app://gists") {
            routingHub.start(url: url, on: navigation)
        }
    }
}
