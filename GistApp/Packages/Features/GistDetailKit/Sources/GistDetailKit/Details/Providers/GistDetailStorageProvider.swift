import StorageKit
import Foundation

protocol GistDetailStorageProviderProtocol {
    func isFavorited(id: String?) -> Bool
    func saveData(dataSource: GistDetailDataSource) -> Bool
    func deleteItem(id: String?) -> Bool
}

final class GistDetailStorageProvider: GistDetailStorageProviderProtocol {
    // MARK: - Properties
    
    private let storageManager: StorageManagerProtocol

    // MARK: - Initializer

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    // MARK: - Methods

    func isFavorited(id: String?) -> Bool {
        guard let id = id else {
            return false
        }

        let entity = GistModel.self
        let result = storageManager.load(key: id, entity: entity)

        switch result {
        case .success(let data):
            return data != nil

        case .failure:
            return false
        }
    }

    func saveData(dataSource: GistDetailDataSource) -> Bool {
        let gistItem = GistItem(
            id: dataSource.id,
            userName: dataSource.userName,
            avatarURL: dataSource.avatarURL,
            filename: dataSource.filename,
            gistContent: dataSource.content, 
            filesQuantity: dataSource.filesQuantity,
            imageData: dataSource.imageData
        )

        guard let data = try? JSONEncoder().encode(gistItem), let id = dataSource.id else {
            return false
        }

        let entity = GistModel.self

        let result = storageManager.save(key: id, data: data, entity: entity)

        switch result {
        case .success:
            return true

        case .failure:
            return false
        }
    }

    func deleteItem(id: String?) -> Bool {
        guard let id = id else { return false }

        let entity = GistModel.self
        let result = storageManager.delete(key: id, entity: entity)

        switch result {
        case .success:
            return true

        case .failure:
            return false
        }
    }
}
