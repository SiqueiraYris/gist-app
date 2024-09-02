public struct GistItem: Codable {
    let id: String?
    let userName: String?
    let avatarURL: String?
    let filename: String?
    let gistContent: String?

    public init(
        id: String? = nil,
        userName: String? = nil,
        avatarURL: String? = nil,
        filename: String? = nil,
        gistContent: String? = nil
    ) {
        self.id = id
        self.userName = userName
        self.avatarURL = avatarURL
        self.filename = filename
        self.gistContent = gistContent
    }
}
