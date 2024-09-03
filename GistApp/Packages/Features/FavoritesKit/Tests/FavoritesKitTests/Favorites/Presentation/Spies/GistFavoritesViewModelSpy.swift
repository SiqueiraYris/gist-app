import ComponentsKit
import DynamicKit
@testable import FavoritesKit

final class GistFavoritesViewModelSpy: GistFavoritesViewModelProtocol {
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)
    var showInformationState: Dynamic<Bool> = Dynamic(false)
    var showToast: Dynamic<Bool> = Dynamic(false)
    var showEmptyState: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)

    enum Message: Equatable {
        case fetch
        case numberOfRowsInSection(section: Int)
        case cellForRowAt(row: Int)
        case back
        case clearFavorites
        case didSelectRowAt(row: Int)
    }

    var receivedMessages = [Message]()

    var numberOfRowsInSection = 0
    var data: DefaultItemData?

    func fetch() {
        receivedMessages.append(.fetch)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        receivedMessages.append(.numberOfRowsInSection(section: section))
        return numberOfRowsInSection
    }

    func cellForRowAt(row: Int) -> DefaultItemData? {
        receivedMessages.append(.cellForRowAt(row: row))
        return data
    }

    func back() {
        receivedMessages.append(.back)
    }

    func clearFavorites() {
        receivedMessages.append(.clearFavorites)
    }

    func didSelectRowAt(row: Int) {
        receivedMessages.append(.didSelectRowAt(row: row))
    }
}
