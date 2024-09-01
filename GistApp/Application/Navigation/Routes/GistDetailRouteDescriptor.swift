import UIKit
import RouterKit
import GistDetailKit

final class GistDetailRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == "gist-detail"
    }

    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?) {
        GistDetailComposer.startScene(navigator, with: userInfo)
    }
}
