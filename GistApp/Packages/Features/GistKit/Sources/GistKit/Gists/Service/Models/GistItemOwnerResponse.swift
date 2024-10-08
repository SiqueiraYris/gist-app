struct GistItemOwnerResponse: Decodable, Equatable {
    let avatarURL: String?
    let userName: String

    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case userName = "login"
    }
}
