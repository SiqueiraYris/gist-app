import NetworkKit

enum InvalidServiceRoute {
    case get

    var config: RequestConfigProtocol {
        switch self {
        case .get:
            return setupGetRequest()
        }
    }

    private func setupGetRequest() -> RequestConfigProtocol {
        let config = RequestConfig(scheme: "https",
                                   host: "any-host",
                                   path: "any-path",
                                   method: .get,
                                   debugMode: Bool.random())
        return config
    }
}
