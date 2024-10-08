import Foundation

struct GistFavoritesDataSource: Encodable, Equatable {
    let id: String?
    let userName: String?
    let avatarURL: String?
    let filename: String?
    let content: String?
    let filesQuantity: Int
    let imageData: Data?
}
