import UIKit
import RouterKit
import GistDetailKit

final class FavoritesRouteDescriptor: RouteDescriptor {
    init() {}

    func match(url: URL) -> Bool {
        return url.host == "favorites"
    }

    func start(url: URL, on navigator: UINavigationController?, with userInfo: [AnyHashable: Any]?) {
        //        GistListComposer.startScene(navigator)
    }
}
