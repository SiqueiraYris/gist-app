struct GistItemResponse: Decodable {
    let owner: GistItemOwnerResponse
    let files: [String: GistItemFileResponse]
}
