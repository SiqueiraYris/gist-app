import CoreData

final class CoreDataProvider {
    private let persistentContainer: NSPersistentContainer

    init() {
        guard let modelURL = Bundle.module.url(forResource: "GistModel", withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to find model in the SPM bundle")
        }

        persistentContainer = NSPersistentContainer(
            name: "GistModel",
            managedObjectModel: managedObjectModel
        )
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }

    func save<T: NSManagedObject>(key: String, data: Data, entity: T.Type) -> Result<Void, Error> {
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)

        do {
            guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
                throw NSError(
                    domain: "CoreDataProvider",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Entity \(entityName) not found in Core Data model"]
                )
            }

            guard let gistEntity = NSManagedObject(entity: entityDescription, insertInto: context) as? GistModel else {
                throw NSError(
                    domain: "CoreDataProvider",
                    code: 2,
                    userInfo: [NSLocalizedDescriptionKey: "Failed to create instance of \(entityName) as GistModel"]
                )
            }

            let gistItem = try JSONDecoder().decode(GistItem.self, from: data)
            gistEntity.userName = gistItem.userName
            gistEntity.avatarURL = gistItem.avatarURL
            gistEntity.gistContent = gistItem.gistContent
            gistEntity.id = gistItem.id
            gistEntity.filename = gistItem.filename
            gistEntity.filesQuantity = Int32(gistItem.filesQuantity)

            try context.save()
            return .success(())

        } catch {
            return .failure(error)
        }
    }

    func load<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Data?, Error> {
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", key)

        do {
            if let result = try context.fetch(fetchRequest).first as? GistModel {
                let gistItem = GistItem(
                    id: result.id,
                    userName: result.userName,
                    avatarURL: result.avatarURL,
                    filename: result.filename,
                    gistContent: result.gistContent, 
                    filesQuantity: Int(result.filesQuantity)
                )

                let data = try JSONEncoder().encode(gistItem)
                return .success(data)
            }
            return .success(nil)
        } catch {
            return .failure(error)
        }
    }

    func delete<T: NSManagedObject>(key: String, entity: T.Type) -> Result<Void, Error> {
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", key)

        do {
            if let result = try context.fetch(fetchRequest).first as? NSManagedObject {
                context.delete(result)
                try context.save()
                return .success(())
            }
            return .failure(
                NSError(
                    domain: "CoreDataProvider",
                    code: 3,
                    userInfo: [NSLocalizedDescriptionKey: "Object not found for key: \(key)"]
                )
            )
        } catch {
            return .failure(error)
        }
    }

    func clear<T: NSManagedObject>(entity: T.Type) -> Result<Void, Error> {
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            results?.forEach { context.delete($0) }
            try context.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func fetchAll<T: NSManagedObject>(entity: T.Type) -> Result<[T], Error> {
        let context = persistentContainer.viewContext
        let entityName = String(describing: entity)

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        do {
            if let results = try context.fetch(fetchRequest) as? [T] {
                return .success(results)
            } else {
                return .success([])
            }
        } catch {
            return .failure(error)
        }
    }
}
