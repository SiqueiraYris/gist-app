import NetworkKit

typealias GistListResult = (Result<([GistItemResponse]), ResponseError>)

protocol GistListServiceProtocol {
    func fetch(
        _ route: GistListServiceRoute,
        completion: @escaping(GistListResult) -> Void
    )
}

final class GistListService: GistListServiceProtocol {
    // MARK: - Properties

    private let manager: NetworkManagerProtocol

    // MARK: - Initializer

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    // MARK: - Methods
    
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
