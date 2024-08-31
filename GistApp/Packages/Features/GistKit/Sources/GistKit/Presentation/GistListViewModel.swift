protocol GistListViewModelProtocol {
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(row: Int)
    func openFavorites()
}

final class GistListViewModel: GistListViewModelProtocol {
    private let coordinator: GistListCoordinatorProtocol
    private let service: GistListServiceProtocol

    init(
        coordinator: GistListCoordinatorProtocol,
        service: GistListServiceProtocol
    ) {
        self.coordinator = coordinator
        self.service = service
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return 2
    }

    func cellForRowAt(row: Int) {

    }

    func openFavorites() {
        coordinator.openFavorites()
    }
}
