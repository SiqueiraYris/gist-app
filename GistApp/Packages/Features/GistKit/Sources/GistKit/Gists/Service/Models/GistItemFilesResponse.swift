struct GistItemFileResponse: Decodable, Equatable {
    let filename: String
    let fileURL: String

    private enum CodingKeys: String, CodingKey {
        case filename
        case fileURL = "raw_url"
    }
}
