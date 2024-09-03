@testable import GistKit

extension GistItemFileResponse: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(filename, forKey: .filename)
        try container.encode(fileURL, forKey: .fileURL)
    }

    enum CodingKeys: String, CodingKey {
        case filename
        case fileURL
    }
}
