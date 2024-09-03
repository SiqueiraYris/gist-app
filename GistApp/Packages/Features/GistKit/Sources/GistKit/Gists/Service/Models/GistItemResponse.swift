struct GistItemResponse: Decodable, Equatable {
    let id: String
    let owner: GistItemOwnerResponse
    let files: [String: GistItemFileResponse]
}
