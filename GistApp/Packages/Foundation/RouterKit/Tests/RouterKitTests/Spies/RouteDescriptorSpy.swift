import UIKit
import RouterKit

final class RouteDescriptorSpy: RouteDescriptor {
    enum Message: Equatable {
        case match(url: URL)
        case startWithNavigationController(url: URL, navigator: UINavigationController?)
    }

    var receivedMessages = [Message]()
    var valueToBeReturned = false

    func match(url: URL) -> Bool {
        receivedMessages.append(.match(url: url))
        return valueToBeReturned
    }

    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?) {
        receivedMessages.append(.startWithNavigationController(url: url, navigator: navigator))
    }
}
