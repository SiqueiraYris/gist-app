import UIKit

public protocol RouteDescriptor: AnyObject {
    func match(url: URL) -> Bool
//    func start(url: URL, on navigator: UINavigationController?)
    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?)
}

//public extension RouteDescriptor {
//    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?)
//}
