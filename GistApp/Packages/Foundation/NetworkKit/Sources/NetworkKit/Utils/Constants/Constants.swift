import Foundation

public struct Constants {
    private static let configurationJson: [String: Any]? = {
        guard
            let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dicInfo = NSDictionary(contentsOfFile: path),
            let dicConfig = dicInfo["Configurations"] as? [String: Any]
        else { return nil }

        return dicConfig
    }()

    public static var serverHost: String = {
        guard let serverHost = configurationJson?["networkHost"] as? String else { return "" }
        return serverHost
    }()

    public static var scheme: String = {
        guard let scheme = configurationJson?["networkScheme"] as? String else { return "" }
        return scheme
    }()
}
