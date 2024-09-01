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
        manager.request(with: route.config) { result in
            switch result {
            case let .success(data):
                let serviceResult = DefaultResultMapper.map(data, to: [GistItemResponse].self)

                switch serviceResult {
                case let .success(data as [GistItemResponse]):
                    completion(.success(data))

                case let .failure(error):
                    completion(.failure(error))

                default:
                    completion(.failure(ResponseError(defaultError: .unknownFailure)))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
