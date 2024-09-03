import XCTest
@testable import FavoritesKit

final class GistFavoritesStorageProviderTests: XCTestCase {
    func test_clear_whenClearSuccessfully_shouldDeliversCorrectValue() {
        let (sut, storageSpy) = makeSUT()

        storageSpy.clearResult = .success(())
        let hasSuccess = sut.clear()

        XCTAssertEqual(storageSpy.receivedMessages, [.clear])
        XCTAssertTrue(hasSuccess)
    }

    func test_clear_whenClearFails_shouldDeliversCorrectValue() {
        let (sut, storageSpy) = makeSUT()

        storageSpy.clearResult = .failure(makeError())
        let hasSuccess = sut.clear()

        XCTAssertEqual(storageSpy.receivedMessages, [.clear])
        XCTAssertFalse(hasSuccess)
    }

    func test_fetchAllGists_whenFetchSuccessfully_shouldDeliversCorrectValue() {
        let (sut, storageSpy) = makeSUT()

        storageSpy.fetchAllResult = .success([])
        let result = sut.fetchAllGists()

        switch result {
        case let .success(success):
            XCTAssertEqual(success, [])

        case .failure:
            XCTFail()
        }

        XCTAssertEqual(storageSpy.receivedMessages, [.fetchAll])
    }

    func test_fetchAllGists_whenFetchFails_shouldDeliversCorrectValue() {
        let (sut, storageSpy) = makeSUT()
        let error = makeError()

        storageSpy.fetchAllResult = .failure(error)
        let result = sut.fetchAllGists()

        switch result {
        case .success:
            XCTFail()

        case let .failure(error):
            XCTAssertEqual(error.localizedDescription, "A operação não pôde ser concluída. (any-domain erro 1.)")
        }

        XCTAssertEqual(storageSpy.receivedMessages, [.fetchAll])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistFavoritesStorageProvider,
        storageSpy: StorageManagerSpy
    ) {
        let storageSpy = StorageManagerSpy()
        let sut = GistFavoritesStorageProvider(storageManager: storageSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(storageSpy)

        return (sut, storageSpy)
    }

    private func makeError() -> NSError {
        return NSError(domain: "any-domain", code: 1)
    }
}
