@testable import GistKit

extension GistItemResponse {
    static func fixture() -> GistItemResponse {
        return GistItemResponse(
            id: "any-id",
            owner: .init(
                avatarURL: "any-avatar-url",
                userName: "any-user-name"
            ),
            files: [
                "any-file": .init(
                    filename: "any-filename",
                    fileURL: "any-file-url"
                )
            ]
        )
    }
}
