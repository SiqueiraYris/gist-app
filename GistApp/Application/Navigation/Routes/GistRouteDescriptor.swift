import UIKit
import RouterKit
import GistKit

final class GistRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == "gists"
    }

    func start(url: URL, on navigator: UINavigationController?) {
        GistListComposer.startScene(navigator)
    }
}
