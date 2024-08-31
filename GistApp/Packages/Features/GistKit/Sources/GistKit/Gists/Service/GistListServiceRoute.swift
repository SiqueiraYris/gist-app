import NetworkKit

enum GistListServiceRoute: NetworkRouteProtocol {
    case fetchGist(page: Int)

    var config: RequestConfigProtocol {
        switch self {
        case let .fetchGist(page):
            return setupFetchGistRequest(page: page)
        }
    }

    private func setupFetchGistRequest(page: Int) -> RequestConfigProtocol {
        let parameters = [
            "page": page,
            "per_page": 10
        ]
        let config = RequestConfig(
            path: "/gists/public",
            method: .get, 
            encoding: .url,
            parameters: parameters,
            debugMode: true
        )
        return config
    }
}
