import DynamicKit
import CommonKit
import ComponentsKit

protocol GistFavoritesViewModelProtocol {
    var shouldReloadData: Dynamic<Bool> { get }
    var showInformationState: Dynamic<Bool> { get }
    var showToast: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }

    func fetch()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(row: Int) -> DefaultItemData?
    func clearFavorites()
}

final class GistFavoritesViewModel: GistFavoritesViewModelProtocol {
    // MARK: - Properties

    private let coordinator: GistFavoritesCoordinatorProtocol
    private let storage: GistFavoritesStorageProviderProtocol
    private var items: [GistFavoritesDataSource] = []

    var shouldReloadData: Dynamic<Bool> = Dynamic(false)
    var showInformationState: Dynamic<Bool> = Dynamic(false)
    var showToast: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)

    // MARK: - Initializer

    init(
        coordinator: GistFavoritesCoordinatorProtocol,
        storage: GistFavoritesStorageProviderProtocol
    ) {
        self.coordinator = coordinator
        self.storage = storage
    }

    func fetch() {
        let result = storage.fetchAllGists()

        switch result {
        case let .success(data):
            items = data
            shouldReloadData.value = true

        case .failure:
            error.value = Strings.loadErrorMessage
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return items.count
    }

    func cellForRowAt(row: Int) -> DefaultItemData? {
        let item = items[safe: row]
        return DefaultItemData(
            title: Strings.userNameTitle.appending(item?.userName ?? ""),
            subtitle: Strings.filesQuantityTitle.appending("\(item?.filesQuantity ?? 0)"),
            image: ""
        )
    }

    func clearFavorites() {
        coordinator.showClearConfirmationAlert { [weak self] confirmed in
            guard let self = self, confirmed else { return }
            self.clear()
        }
    }

    private func clear() {
        let hasSuccess = storage.clear()

        if hasSuccess {
            fetch()
            showToast.value = true
        } else {
            coordinator.showErrorAlert(with: Strings.clearErrorMessage) { [weak self] in
                self?.clearFavorites()
            }
        }
    }
}
