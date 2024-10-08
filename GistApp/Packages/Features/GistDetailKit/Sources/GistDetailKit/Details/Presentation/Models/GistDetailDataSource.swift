import Foundation

struct GistDetailDataSource: Decodable, Equatable {
    let id: String?
    let avatarURL: String?
    let userName: String?
    let filename: String?
    let fileURL: String?
    var content: String?
    let filesQuantity: Int
    var imageData: Data?
}
