import NetworkKit

typealias GistListResult = (Result<([GistItemResponse]), ResponseError>)

protocol GistListServiceProtocol {
    func fetch(
        _ route: GistListServiceRoute,
        completion: @escaping(GistListResult) -> Void
    )
}

final class GistListService: GistListServiceProtocol {
    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    func fetch(
        _ route: GistListServiceRoute,
        completion: @escaping(GistListResult) -> Void
    ) {
        manager.request(with: route.config, completion: completion)
    }
}
