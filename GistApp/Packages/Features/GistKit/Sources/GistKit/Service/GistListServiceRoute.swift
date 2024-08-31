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
        let config = RequestConfig(
            path: "/gists/public?page=\(page)",
            method: .get, debugMode: true
        )
        return config
    }
}
