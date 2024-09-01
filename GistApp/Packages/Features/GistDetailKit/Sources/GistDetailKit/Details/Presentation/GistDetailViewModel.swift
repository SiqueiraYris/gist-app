protocol GistDetailViewModelProtocol {
    func getUserName() -> String?
    func getAvatar() -> String?
}

final class GistDetailViewModel: GistDetailViewModelProtocol {
    private let coordinator: GistDetailCoordinatorProtocol
    private let dataSource: GistDetailDataSource

    init(coordinator: GistDetailCoordinatorProtocol, dataSource: GistDetailDataSource) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }

    func getUserName() -> String? {
        return dataSource.userName
    }

    func getAvatar() -> String? {
        return dataSource.avatarURL
    }
}
