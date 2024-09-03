import Foundation
@testable import FavoritesKit

extension GistFavoritesDataSource {
    static func fixture() -> GistFavoritesDataSource {
        return GistFavoritesDataSource(
            id: "any-id", 
            userName: "any-user-name",
            avatarURL: "any-avatar-url",
            filename: "any-filename",
            content: "any-content",
            filesQuantity: 1,
            imageData: Data()
        )
    }
}
