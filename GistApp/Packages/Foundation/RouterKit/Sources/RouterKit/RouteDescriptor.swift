import UIKit

public protocol RouteDescriptor: AnyObject {
    func match(url: URL) -> Bool
    func start()
    func start(url: URL)
    func start(url: URL, on viewController: UIViewController)
    func start(url: URL, on navigator: UINavigationController)
}

public extension RouteDescriptor {
    func start() { }
    func start(url: URL) { }
    func start(url: URL, on viewController: UIViewController) { }
    func start(url: URL, on navigator: UINavigationController) { }
}
