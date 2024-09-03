@testable import GistDetailKit

extension GistDetailDataSource {
    static func fixture(content: String? = "any-content") -> GistDetailDataSource {
        return GistDetailDataSource(
            id: "any-id",
            avatarURL: "any-avatar-url", 
            userName: "any-user-name",
            filename: "any-filename",
            fileURL: "https://any-host/any-path",
            content: content,
            filesQuantity: 1,
            imageData: nil
        )
    }
}
