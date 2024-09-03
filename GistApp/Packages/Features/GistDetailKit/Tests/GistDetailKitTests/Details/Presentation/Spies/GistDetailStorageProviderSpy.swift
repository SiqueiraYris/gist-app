@testable import GistDetailKit

final class GistDetailStorageProviderSpy: GistDetailStorageProviderProtocol {
    enum Message: Equatable {
        case isFavorited(id: String?)
        case saveData(dataSource: GistDetailDataSource)
        case deleteItem(id: String?)
    }

    var receivedMessages = [Message]()

    var isFavoritedResult = false
    var saveDataResult = false
    var deleteResult = false

    func isFavorited(id: String?) -> Bool {
        receivedMessages.append(.isFavorited(id: id))
        return isFavoritedResult
    }

    func saveData(dataSource: GistDetailDataSource) -> Bool {
        receivedMessages.append(.saveData(dataSource: dataSource))
        return saveDataResult
    }

    func deleteItem(id: String?) -> Bool {
        receivedMessages.append(.deleteItem(id: id))
        return deleteResult
    }
}
