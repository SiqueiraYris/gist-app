import NetworkKit
import Foundation

typealias GistDetailResult = (Result<(String), ResponseError>)

protocol GistDetailServiceProtocol {
    func fetch(
        _ route: GistDetailServiceRoute,
        completion: @escaping(GistDetailResult) -> Void
    )
}

final class GistDetailService: GistDetailServiceProtocol {
    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    func fetch(
        _ route: GistDetailServiceRoute,
        completion: @escaping(GistDetailResult) -> Void
    ) {
        manager.request(with: route.config) { result in
            switch result {
            case let.success(data):
                if let gistContent = String(data: data, encoding: .utf8) {
                    completion(.success(gistContent))
                } else {
                    completion(.failure(ResponseError(defaultError: .unknownFailure)))
                }

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

