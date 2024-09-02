import Foundation
import DatabaseKit

protocol GistFavoritesStorageProviderProtocol { 
    func fetchAllGists() -> Result<[GistFavoritesDataSource], Error>
    func clear() -> Bool
}

final class GistFavoritesStorageProvider: GistFavoritesStorageProviderProtocol {
    // MARK: - Properties

    private let storageManager: StorageManagerProtocol

    // MARK: - Initializer

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    // MARK: - Methods

    func fetchAllGists() -> Result<[GistFavoritesDataSource], Error> {
        let result = storageManager.fetchAll(entity: GistModel.self)

        switch result {
        case let .success(gistModels):
            let gistItems = gistModels.compactMap { gistModel in
                GistFavoritesDataSource(
                    id: gistModel.id,
                    userName: gistModel.userName,
                    avatarURL: gistModel.avatarURL,
                    filename: gistModel.filename,
                    content: gistModel.gistContent, 
                    filesQuantity: Int(gistModel.filesQuantity), 
                    imageData: gistModel.imageData
                )
            }
            return .success(gistItems)

        case let .failure(error):
            return .failure(error)
        }
    }

    func clear() -> Bool {
        let result = storageManager.clear(entity: GistModel.self)

        switch result {
        case .success:
            return true

        case .failure:
            return false
        }
    }
}
