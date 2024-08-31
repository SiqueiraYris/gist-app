import UIKit

final class AppStarter {
    private static var window: UIWindow? = {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        return sceneDelegate?.window
    }()

    static func start() {
        startApp()
    }

    private static func startApp() {
        let navigation = UINavigationController()

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
