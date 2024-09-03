import ComponentsKit
import DynamicKit
@testable import GistKit

final class GistListViewModelSpy: GistListViewModelProtocol {
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var shouldReloadData: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)

    var defaultItemDataToBeReturned: DefaultItemData?
    var numberOfRowsInSectionToBeReturned = 0

    enum Message: Equatable {
        case fetch
        case retryLastFetch
        case resetPagination
        case numberOfRowsInSection(section: Int)
        case cellForRowAt(row: Int)
        case didSelectRowAt(row: Int)
        case openFavorites
    }

    var receivedMessages = [Message]()

    func fetch() {
        receivedMessages.append(.fetch)
    }

    func retryLastFetch() {
        receivedMessages.append(.retryLastFetch)
    }

    func resetPagination() {
        receivedMessages.append(.resetPagination)
    }

    func numberOfRowsInSection(section: Int) -> Int {
        receivedMessages.append(.numberOfRowsInSection(section: section))
        return numberOfRowsInSectionToBeReturned
    }

    func cellForRowAt(row: Int) -> DefaultItemData? {
        receivedMessages.append(.cellForRowAt(row: row))
        return defaultItemDataToBeReturned
    }

    func didSelectRowAt(row: Int) {
        receivedMessages.append(.didSelectRowAt(row: row))
    }
    
    func openFavorites() {
        receivedMessages.append(.openFavorites)
    }
}
