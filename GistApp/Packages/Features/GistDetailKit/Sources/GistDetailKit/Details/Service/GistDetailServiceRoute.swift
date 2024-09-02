import NetworkKit

enum GistDetailServiceRoute: NetworkRouteProtocol {
    case fetchDetail(request: GistDetailRequest)

    var config: RequestConfigProtocol {
        switch self {
        case let .fetchDetail(request):
            return setupFetchDetailRequest(request: request)
        }
    }

    private func setupFetchDetailRequest(request: GistDetailRequest) -> RequestConfigProtocol {
        let config = RequestConfig(
            host: request.host,
            path: request.path,
            method: .get
        )
        return config
    }
}
