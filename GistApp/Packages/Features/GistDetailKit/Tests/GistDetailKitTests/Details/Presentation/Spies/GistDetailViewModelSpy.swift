import DynamicKit
import ComponentsKit
@testable import GistDetailKit

final class GistDetailViewModelSpy: GistDetailViewModelProtocol {
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
    var content: Dynamic<String?> = Dynamic(nil)
    var isFavorited: Dynamic<Bool> = Dynamic(false)
    var showData: Dynamic<Bool> = Dynamic(false)

    enum Message: Equatable {
        case fetch
        case getData
        case getTitleData
        case copyContent(text: String?)
        case favoriteItem
        case getIcon
    }

    var receivedMessages = [Message]()

    var data: DefaultItemData?
    var title: String?
    var icon = ""

    func fetch() {
        receivedMessages.append(.fetch)
    }
    
    func getData() -> ComponentsKit.DefaultItemData? {
        receivedMessages.append(.getData)
        return data
    }
    
    func getTitleData() -> String? {
        receivedMessages.append(.getTitleData)
        return title
    }
    
    func copyContent(text: String?) {
        receivedMessages.append(.copyContent(text: text))
    }
    
    func favoriteItem() {
        receivedMessages.append(.favoriteItem)
    }
    
    func getIcon() -> String {
        receivedMessages.append(.getIcon)
        return icon
    }
}
