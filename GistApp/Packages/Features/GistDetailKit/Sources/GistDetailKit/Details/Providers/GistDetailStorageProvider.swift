import StorageKit
import Foundation

protocol GistDetailStorageProviderProtocol {
    func saveData(
        id: String?,
        userName: String?,
        avatarURL: String?, 
        filename: String?,
        gistContent: String?
    ) -> Bool
}

final class GistDetailStorageProvider: GistDetailStorageProviderProtocol {
    // MARK: - Properties
    
    private let storageManager: StorageManagerProtocol

    // MARK: - Initializer

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }

    // MARK: - Methods

//    func isFavorited() -> Bool {
//
//    }

    func saveData(
        id: String?,
        userName: String?,
        avatarURL: String?,
        filename: String?,
        gistContent: String?
    ) -> Bool {
        let gistItem = GistItem(
            id: id,
            userName: userName,
            avatarURL: avatarURL,
            filename: filename,
            gistContent: gistContent
        )

        guard let data = try? JSONEncoder().encode(gistItem) else {
            return false
        }

        let entity = GistModel.self

        let result = storageManager.save(key: "gist-item", data: data, entity: entity)

        switch result {
        case .success:
            return true

        case .failure:
            return false
        }
    }
}
