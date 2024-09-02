import UIKit
import DynamicKit
import ComponentsKit

protocol GistDetailViewModelProtocol {
    var isLoading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }
    var content: Dynamic<String?> { get }
    var isFavorited: Dynamic<Bool> { get }

    func fetch()
    func getData() -> DefaultItemData?
    func getUserName() -> String?
    func getAvatar() -> String?
    func copyContent(text: String?)
    func favoriteItem()
    func getIcon() -> String
}

final class GistDetailViewModel: GistDetailViewModelProtocol {
    // MARK: - Properties
    
    private let coordinator: GistDetailCoordinatorProtocol
    private let service: GistDetailServiceProtocol
    private let storageProvider: GistDetailStorageProviderProtocol
    private var dataSource: GistDetailDataSource

    var isLoading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    var content: Dynamic<String?> = Dynamic(nil)
    var isFavorited: Dynamic<Bool> = Dynamic(false)

    // MARK: - Initializer
    
    init(
        coordinator: GistDetailCoordinatorProtocol,
        service: GistDetailServiceProtocol,
        storageProvider: GistDetailStorageProviderProtocol,
        dataSource: GistDetailDataSource
    ) {
        self.coordinator = coordinator
        self.service = service
        self.storageProvider = storageProvider
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
                self.dataSource.content = content
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

    func getData() -> DefaultItemData? {
        return DefaultItemData(
            title: Strings.userNameTitle.appending(dataSource.userName ?? ""),
            subtitle: Strings.filesQuantityTitle.appending("\(dataSource.filesQuantity)"),
            image: dataSource.avatarURL
        )
    }

    func copyContent(text: String?) {
        UIPasteboard.general.string = text
    }

    func favoriteItem() {
        if storageProvider.isFavorited(id: dataSource.id) {
            let hasDeleted = storageProvider.deleteItem(id: dataSource.id)

            if hasDeleted {
                isFavorited.value = false
            } else {
                isFavorited.value = true
                showStorageErrorAlert()
            }
        } else {
            let hasSaved = storageProvider.saveData(dataSource: dataSource)

            if hasSaved {
                isFavorited.value = true
            } else {
                isFavorited.value = false
                showStorageErrorAlert()
            }
        }
    }

    func getIcon() -> String {
        return storageProvider.isFavorited(id: dataSource.id) ? "star.fill" : "star"
    }

    private func showStorageErrorAlert() {
        coordinator.showErrorAlert(
            with: Strings.genericErrorMessage
        ) { [weak self] in
            self?.favoriteItem()
        }
    }
}
