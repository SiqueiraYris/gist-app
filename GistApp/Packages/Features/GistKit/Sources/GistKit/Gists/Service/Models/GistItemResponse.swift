struct GistItemResponse: Decodable {
    let id: String
    let owner: GistItemOwnerResponse
    let files: [String: GistItemFileResponse]
}
