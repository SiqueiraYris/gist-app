import UIKit

public protocol RouteDescriptor: AnyObject {
    func match(url: URL) -> Bool
    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?)
}
