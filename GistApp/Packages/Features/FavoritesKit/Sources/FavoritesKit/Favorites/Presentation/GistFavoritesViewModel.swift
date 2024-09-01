import DynamicKit

protocol GistFavoritesViewModelProtocol { }

final class GistFavoritesViewModel: GistFavoritesViewModelProtocol {
    // MARK: - Properties

    private let coordinator: GistFavoritesCoordinatorProtocol

    // MARK: - Initializer

    init(coordinator: GistFavoritesCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
