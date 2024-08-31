import NetworkKit

typealias GistListResult = (Result<(GistItemResponse), ResponseError>)

protocol GistListServiceProtocol/*: AnyObject*/ {
    func request(_ route: GistListServiceRoute, completion: @escaping(GistListResult) -> Void)
}

final class GistListService: GistListServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networking: NetworkManagerProtocol) {
        self.networkManager = networking
    }

    func request(_ route: GistListServiceRoute, completion: @escaping(GistListResult) -> Void) {
        networkManager.request(with: route.config, completion: completion)
    }
}
