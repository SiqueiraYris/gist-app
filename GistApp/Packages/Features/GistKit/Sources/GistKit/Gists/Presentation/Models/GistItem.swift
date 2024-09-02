import Foundation

struct GistItem: Encodable {
    let id: String?
    let avatarURL: String?
    let userName: String?
    let filename: String?
    let fileURL: String?
    let filesQuantity: Int
}
