import UIKit
import RouterKit

final class RoutingHubSpy: RoutingHubProtocol {
    var descriptors: [RouteDescriptor] = []

    enum Message: Equatable {
        case start(url: URL, navigation: UINavigationController?)
        case register
    }

    var receivedMessages = [Message]()

    func start(url: URL, on navigation: UINavigationController?, with userInfo: [AnyHashable: Any]?) {
        receivedMessages.append(.start(url: url, navigation: navigation))
    }

    func register(descriptor: RouteDescriptor) {
        receivedMessages.append(.register)
    }
}
