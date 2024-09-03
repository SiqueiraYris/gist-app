@testable import GistKit

extension GistItemOwnerResponse: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(avatarURL, forKey: .avatarURL)
        try container.encode(userName, forKey: .userName)
    }

    enum CodingKeys: String, CodingKey {
        case avatarURL
        case userName
        case files
    }
}
