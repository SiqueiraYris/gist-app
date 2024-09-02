import Foundation
import CoreData

public protocol StorageManagerProtocol {
    func save<T: NSManagedObject>(key: String, data: Data, entity: T.Type) -> Result<Void, Error>
    func delete<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Void, Error>
    func load<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Data?, Error>
    func clear<T: NSManagedObject>(entity: T.Type) -> Result<Void, Error>
    func fetchAll<T: NSManagedObject>(entity: T.Type) -> Result<[T], Error>
}

public final class StorageManager: StorageManagerProtocol {
    private let coreDataProvider: CoreDataProvider

    public static let shared = StorageManager()

    private init() {
        self.coreDataProvider = CoreDataProvider()
    }

    public func save<T: NSManagedObject>(key: String, data: Data, entity: T.Type) -> Result<Void, Error> {
        return coreDataProvider.save(key: key, data: data, entity: entity)
    }

    public func delete<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Void, Error> {
        return coreDataProvider.delete(key: key, entity: entity)
    }

    public func load<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Data?, Error> {
        return coreDataProvider.load(key: key, entity: entity)
    }

    public func clear<T: NSManagedObject>(entity: T.Type) -> Result<Void, Error> {
        return coreDataProvider.clear(entity: entity)
    }

    public func fetchAll<T: NSManagedObject>(entity: T.Type) -> Result<[T], Error> {
        return coreDataProvider.fetchAll(entity: entity)
    }
}
