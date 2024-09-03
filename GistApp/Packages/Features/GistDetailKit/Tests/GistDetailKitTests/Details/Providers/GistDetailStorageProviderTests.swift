import XCTest
import DatabaseKit
@testable import GistDetailKit

final class GistDetailStorageProviderTests: XCTestCase {
    func test_isFavorited_returnsTrue_whenItemExists() {
        let (sut, storageSpy) = makeSUT()
        let id = "123"

        storageSpy.loadResult = .success(Data())

        let result = sut.isFavorited(id: id)

        XCTAssertTrue(result)
        XCTAssertEqual(storageSpy.receivedMessages, [.load(key: id)])
    }

    func test_isFavorited_returnsFalse_whenItemDoesNotExist() {
        let (sut, storageSpy) = makeSUT()
        let id = "123"

        storageSpy.loadResult = .success(nil) // Simulating no data found

        let result = sut.isFavorited(id: id)

        XCTAssertFalse(result)
        XCTAssertEqual(storageSpy.receivedMessages, [.load(key: id)])
    }

    func test_isFavorited_returnsFalse_whenLoadFails() {
        let (sut, storageSpy) = makeSUT()
        let id = "123"

        storageSpy.loadResult = .failure(makeError()) // Simulating a failure in load

        let result = sut.isFavorited(id: id)

        XCTAssertFalse(result)
        XCTAssertEqual(storageSpy.receivedMessages, [.load(key: id)])
    }

    func test_saveData_returnsTrue_whenSaveSucceeds() {
        let (sut, storageSpy) = makeSUT()
        let dataSource = makeGistDetailDataSource(id: "123")

        storageSpy.saveResult = .success(())

        let result = sut.saveData(dataSource: dataSource)

        XCTAssertTrue(result)
//        XCTAssertEqual(storageSpy.receivedMessages, [.save(key: "123", data: try! JSONEncoder().encode(dataSource.toGistItem()))])
    }

    func test_saveData_returnsFalse_whenSaveFails() {
        let (sut, storageSpy) = makeSUT()
        let dataSource = makeGistDetailDataSource(id: "123")

        storageSpy.saveResult = .failure(makeError())

        let result = sut.saveData(dataSource: dataSource)

        XCTAssertFalse(result)
//        XCTAssertEqual(storageSpy.receivedMessages, [.save(key: "123", data: try! JSONEncoder().encode(dataSource.toGistItem()))])
    }

    func test_deleteItem_returnsTrue_whenDeleteSucceeds() {
        let (sut, storageSpy) = makeSUT()
        let id = "123"

        storageSpy.deleteResult = .success(())

        let result = sut.deleteItem(id: id)

        XCTAssertTrue(result)
        XCTAssertEqual(storageSpy.receivedMessages, [.delete(key: id)])
    }

    func test_deleteItem_returnsFalse_whenDeleteFails() {
        let (sut, storageSpy) = makeSUT()
        let id = "123"

        storageSpy.deleteResult = .failure(makeError())

        let result = sut.deleteItem(id: id)

        XCTAssertFalse(result)
        XCTAssertEqual(storageSpy.receivedMessages, [.delete(key: id)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistDetailStorageProvider,
        storageSpy: StorageManagerSpy
    ) {
        let storageSpy = StorageManagerSpy()
        let sut = GistDetailStorageProvider(storageManager: storageSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(storageSpy)

        return (sut, storageSpy)
    }

    private func makeError() -> NSError {
        return NSError(domain: "any-domain", code: 1)
    }

    private func makeGistDetailDataSource(id: String) -> GistDetailDataSource {
        return GistDetailDataSource(
            id: id,
            avatarURL: "any-avatar-url",
            userName: "any-user-name",
            filename: "any-filename",
            fileURL: "any-file-url",
            content: "any-content",
            filesQuantity: 1,
            imageData: nil
        )
    }
}
//
//extension GistDetailDataSource {
//    func toGistItem() -> GistItem {
//        return GistItem(
//            id: self.id,
//            userName: self.userName,
//            avatarURL: self.avatarURL,
//            filename: self.filename,
//            gistContent: self.content,
//            filesQuantity: self.filesQuantity,
//            imageData: self.imageData
//        )
//    }
//}
