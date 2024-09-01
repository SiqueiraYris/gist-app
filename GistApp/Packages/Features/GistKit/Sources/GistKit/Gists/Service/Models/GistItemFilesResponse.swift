struct GistItemFileResponse: Decodable {
    let filename: String
    let fileURL: String

    private enum CodingKeys: String, CodingKey {
        case filename
        case fileURL = "raw_url"
    }
}
