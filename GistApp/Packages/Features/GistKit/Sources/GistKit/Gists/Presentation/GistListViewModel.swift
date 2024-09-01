import DynamicKit
import CommonKit
import ComponentsKit

protocol GistListViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var shouldReloadData: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }

    func fetch()
    func retryLastFetch()
    func resetPagination()
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt(row: Int) -> DefaultItemData?
    func didSelectRowAt(row: Int)
    func openFavorites()
}

final class GistListViewModel: GistListViewModelProtocol {
    // MARK: - Properties

    private let coordinator: GistListCoordinatorProtocol
    private let service: GistListServiceProtocol
    private var currentPage = 0
    private var isLastPage = false
    private var isFetching = false
    private var lastFetchFailed = false
    private var gists: [GistItemResponse] = []

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)

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
        lastFetchFailed = false

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
                if self.numberOfRowsInSection(section: 0) == 0 {
                    self.lastFetchFailed = true
                    self.error.value = error.errorDescription
                } else {
                    self.coordinator.showErrorAlert(
                        with: error.errorDescription ?? error.localizedDescription
                    ) { [weak self] in
                        self?.retryLastFetch()
                    }
                }
            }
        }
    }

    func retryLastFetch() {
        if lastFetchFailed {
            fetch()
        }
    }

    func resetPagination() {
        currentPage = 0
        isLastPage = false
        gists.removeAll()
        shouldReloadData.value = true
    }

    func numberOfRowsInSection(section: Int) -> Int {
        return gists.count
    }

    func cellForRowAt(row: Int) -> DefaultItemData? {
        guard row < gists.count, let item = gists[safe: row] else { return nil }

        return DefaultItemData(
            title: Strings.userNameTitle.appending(item.owner.userName),
            subtitle: Strings.filesQuantityTitle.appending("\(item.files.count)"),
            image: item.owner.avatarURL
        )
    }

    func didSelectRowAt(row: Int) {
        guard let item = gists[safe: row] else { return }
        let gist = GistItem(
            avatarURL: item.owner.avatarURL,
            userName: item.owner.userName,
            fileURL: item.files.first?.value.fileURL
        )
        coordinator.openDetails(with: gist.toDictionary())
    }

    func openFavorites() {
        coordinator.openFavorites()
    }
}
