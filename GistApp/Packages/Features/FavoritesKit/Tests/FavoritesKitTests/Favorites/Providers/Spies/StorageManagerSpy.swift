import CoreData
import DatabaseKit

final class StorageManagerSpy: StorageManagerProtocol {
    enum Message: Equatable {
        case save(key: String, data: Data)
        case delete(key: String)
        case load(key: String)
        case clear
        case fetchAll
    }

    var receivedMessages = [Message]()

    var clearResult: Result<Void, Error>?
    var fetchAllResult: Result<[GistModel], Error>?

    func save<T: NSManagedObject>(key: String, data: Data, entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.save(key: key, data: data))
        return .success(())
    }

    func delete<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.delete(key: key))
        return .success(())
    }

    func load<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Data?, Error> {
        receivedMessages.append(.load(key: key))
        return .success(nil)
    }

    func clear<T: NSManagedObject>(entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.clear)
        return clearResult!
    }

    func fetchAll<T: NSManagedObject>(entity: T.Type) -> Result<[T], Error> {
        receivedMessages.append(.fetchAll)
        return fetchAllResult as! Result<[T], Error>
    }
}
