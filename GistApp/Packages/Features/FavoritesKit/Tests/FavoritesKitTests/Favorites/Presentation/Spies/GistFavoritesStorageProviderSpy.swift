@testable import FavoritesKit

final class GistFavoritesStorageProviderSpy: GistFavoritesStorageProviderProtocol {
    enum Message: Equatable {
        case fetchAllGists
        case clear
    }

    var receivedMessages = [Message]()

    var fetchAllGistsResult: Result<[GistFavoritesDataSource], Error>?
    var clearResult = false

    func fetchAllGists() -> Result<[GistFavoritesDataSource], Error> {
        receivedMessages.append(.fetchAllGists)
        return fetchAllGistsResult!
    }

    func clear() -> Bool {
        receivedMessages.append(.clear)
        return clearResult
    }
}
