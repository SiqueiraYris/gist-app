@testable import GistKit

extension GistItemResponse: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(owner, forKey: .owner)
        try container.encode(files, forKey: .files)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case files
    }
}
