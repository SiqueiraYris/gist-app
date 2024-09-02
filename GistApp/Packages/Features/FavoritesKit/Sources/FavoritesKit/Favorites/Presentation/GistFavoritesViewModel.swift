import DynamicKit
import ComponentsKit

protocol GistFavoritesViewModelProtocol { 
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(row: Int) -> DefaultItemData?
}

final class GistFavoritesViewModel: GistFavoritesViewModelProtocol {
    // MARK: - Properties

    private let coordinator: GistFavoritesCoordinatorProtocol
    private let storage: GistFavoritesStorageProviderProtocol

    // MARK: - Initializer

    init(
        coordinator: GistFavoritesCoordinatorProtocol,
        storage: GistFavoritesStorageProviderProtocol
    ) {
        self.coordinator = coordinator
        self.storage = storage
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return 2
    }

    func cellForRowAt(row: Int) -> DefaultItemData? {
        return DefaultItemData(title: "test", subtitle: "Arquivo: text.txt")
    }
}
