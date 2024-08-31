import DynamicKit

protocol GistListViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var shouldReloadData: Dynamic<Bool> { get }

    func fetch()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(row: Int) -> (title: String?, subtitle: String?)
    func openFavorites()
}

final class GistListViewModel: GistListViewModelProtocol {
    // MARK: - Properties

    private let coordinator: GistListCoordinatorProtocol
    private let service: GistListServiceProtocol
    private var currentPage = 0
    private var isLastPage = false
    private var isFetching = false
    private var gists: [GistItemResponse] = []

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)

    // MARK: - Initializer

    init(
        coordinator: GistListCoordinatorProtocol,
        service: GistListServiceProtocol
    ) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Methods

    func fetch() {
        guard !isFetching && !isLastPage else { return }
        isLoading.value = currentPage == 0
        isFetching = true

        let route = GistListServiceRoute.fetchGist(page: currentPage)
        service.fetch(route) { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false
            self.isFetching = false

            switch result {
            case let .success(response):
                self.gists.append(contentsOf: response)
                self.isLastPage = response.isEmpty
                self.currentPage += 1
                self.shouldReloadData.value = true

            case let .failure(error):
                print("Error fetching gists: \(error.localizedDescription)")
            }
        }
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return gists.count
    }

    func cellForRowAt(row: Int) -> (title: String?, subtitle: String?) {
        guard row < gists.count else { return (title: nil, subtitle: nil) }
        return (
            title: Strings.userNameTitle.appending(gists[row].owner.userName),
            subtitle: Strings.filesQuantityTitle.appending("\(gists[row].files.count)")
        )
    }

    func openFavorites() {
        coordinator.openFavorites()
    }
}
