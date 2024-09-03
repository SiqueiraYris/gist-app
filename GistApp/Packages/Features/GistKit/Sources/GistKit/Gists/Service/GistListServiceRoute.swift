import NetworkKit

enum GistListServiceRoute: NetworkRouteProtocol, Equatable {
    case fetchGist(page: Int)

    var config: RequestConfigProtocol {
        switch self {
        case let .fetchGist(page):
            return setupFetchGistRequest(page: page)
        }
    }

    private enum Constants {
        static let selectedPage = "page"
        static let quantityPerPage = "per_page"
    }

    private func setupFetchGistRequest(page: Int) -> RequestConfigProtocol {
        let parameters = [
            Constants.selectedPage: page,
            Constants.quantityPerPage: 10
        ]
        let config = RequestConfig(
            path: "/gists/public",
            method: .get, 
            encoding: .url,
            parameters: parameters
        )
        return config
    }
}
