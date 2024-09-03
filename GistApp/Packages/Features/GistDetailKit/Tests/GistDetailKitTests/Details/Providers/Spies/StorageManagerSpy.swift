import CoreData
import DatabaseKit

final class StorageManagerSpy: DatabaseManagerProtocol {
    enum Message: Equatable {
        case save(key: String, data: Data)
        case delete(key: String)
        case load(key: String)
        case clear
        case fetchAll
    }

    var receivedMessages = [Message]()

    var loadResult: Result<Data?, Error>?
    var saveResult: Result<Void, Error>?
    var deleteResult: Result<Void, Error>?

    func save<T: NSManagedObject>(key: String, data: Data, entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.save(key: key, data: data))
        return saveResult!
    }

    func delete<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.delete(key: key))
        return deleteResult!
    }

    func load<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Data?, Error> {
        receivedMessages.append(.load(key: key))
        return loadResult!
    }

    func clear<T: NSManagedObject>(entity: T.Type) -> Result<Void, Error> {
        receivedMessages.append(.clear)
        return .success(())
    }

    func fetchAll<T: NSManagedObject>(entity: T.Type) -> Result<[T], Error> {
        receivedMessages.append(.fetchAll)
        return .success([])
    }
}
