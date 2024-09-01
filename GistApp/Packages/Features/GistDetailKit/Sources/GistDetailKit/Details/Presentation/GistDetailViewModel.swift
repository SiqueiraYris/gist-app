import UIKit
import DynamicKit

protocol GistDetailViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }
    var content: Dynamic<String?> { get }

    func fetch()
    func getUserName() -> String?
    func getAvatar() -> String?
    func copyContent(text: String?)
    func favoriteItem()
}

final class GistDetailViewModel: GistDetailViewModelProtocol {
    private let coordinator: GistDetailCoordinatorProtocol
    private let service: GistDetailServiceProtocol
    private let dataSource: GistDetailDataSource

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    var content: Dynamic<String?> = Dynamic(nil)

    init(
        coordinator: GistDetailCoordinatorProtocol,
        service: GistDetailServiceProtocol,
        dataSource: GistDetailDataSource
    ) {
        self.coordinator = coordinator
        self.service = service
        self.dataSource = dataSource
    }

    // MARK: - Methods

    func fetch() {
        isLoading.value = true

        guard let fileURL = dataSource.fileURL,
              let url = URL(string: fileURL),
              let host = url.host else { return }
        let request = GistDetailRequest(host: host, path: url.path)
        let route = GistDetailServiceRoute.fetchDetail(request: request)

        service.fetch(route) { [weak self] result in
            guard let self else { return }
            self.isLoading.value = false

            switch result {
            case let .success(content):
                self.content.value = content

            case let .failure(error):
                self.error.value = error.errorDescription
            }
        }
    }

    func getUserName() -> String? {
        return dataSource.userName
    }

    func getAvatar() -> String? {
        return dataSource.avatarURL
    }

    func copyContent(text: String?) {
        UIPasteboard.general.string = text
    }

    func favoriteItem() {
        // TODO: - Save in core data
        // TODO: - Change icon when it's saved
    }
}
