import XCTest
@testable import FavoritesKit

final class GistFavoritesViewModelTests: XCTestCase {
    func test_fetch_withSuccess_shouldReloadData() {
        let (sut, _, storageSpy) = makeSUT()

        storageSpy.fetchAllGistsResult = .success([GistFavoritesDataSource.fixture()])

        sut.fetch()

        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertFalse(sut.showInformationState.value)
        XCTAssertNil(sut.error.value)
    }

    func test_fetch_withEmptyResult_shouldShowInformationState() {
        let (sut, _, storageSpy) = makeSUT()

        storageSpy.fetchAllGistsResult = .success([])

        sut.fetch()

        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertTrue(sut.showInformationState.value)
        XCTAssertNil(sut.error.value)
    }

    func test_fetch_withFailure_shouldSetError() {
        let (sut, _, storageSpy) = makeSUT()

        storageSpy.fetchAllGistsResult = .failure(makeError())

        sut.fetch()

        XCTAssertFalse(sut.shouldReloadData.value)
        XCTAssertEqual(sut.error.value, Strings.loadErrorMessage)
    }

    func test_numberOfRowsInSection_shouldReturnCorrectCount() {
        let (sut, _, storageSpy) = makeSUT()

        storageSpy.fetchAllGistsResult = .success([GistFavoritesDataSource.fixture(), GistFavoritesDataSource.fixture()])
        sut.fetch()

        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), 2)
    }

    func test_cellForRowAt_shouldReturnCorrectData() {
        let (sut, _, storageSpy) = makeSUT()

        let dataSource = GistFavoritesDataSource.fixture()
        storageSpy.fetchAllGistsResult = .success([dataSource])
        sut.fetch()

        let cellData = sut.cellForRowAt(row: 0)

        XCTAssertEqual(cellData?.title, Strings.userNameTitle.appending(dataSource.userName!))
        XCTAssertEqual(cellData?.subtitle, Strings.filesQuantityTitle.appending("\(dataSource.filesQuantity)"))
        XCTAssertEqual(cellData?.imageData, dataSource.imageData)
    }

    func test_back_shouldTriggerCoordinatorBack() {
        let (sut, coordinatorSpy, _) = makeSUT()

        sut.back()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.back])
    }

    func test_clearFavorites_withConfirmation_shouldClearFavorites() {
        let (sut, coordinatorSpy, storageSpy) = makeSUT()
        coordinatorSpy.confirmationToBeReturned = true
        storageSpy.clearResult = true
        storageSpy.fetchAllGistsResult = .success([])

        sut.clearFavorites()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showClearConfirmationAlert])
        XCTAssertTrue(sut.showToast.value)
        XCTAssertTrue(sut.showInformationState.value)
        XCTAssertEqual(storageSpy.receivedMessages, [.clear, .fetchAllGists])
    }

    func test_clearFavorites_withoutConfirmation_shouldNotClearFavorites() {
        let (sut, coordinatorSpy, storageSpy) = makeSUT()
        coordinatorSpy.confirmationToBeReturned = false
        
        sut.clearFavorites()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.showClearConfirmationAlert])
        XCTAssertEqual(storageSpy.receivedMessages, [])
    }

    func test_didSelectRowAt_shouldTriggerCoordinatorOpenDetails() {
        let (sut, coordinatorSpy, storageSpy) = makeSUT()

        let dataSource = GistFavoritesDataSource.fixture()
        storageSpy.fetchAllGistsResult = .success([dataSource])
        sut.fetch()

        sut.didSelectRowAt(row: 0)

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openDetails])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistFavoritesViewModel,
        coordinatorSpy: GistFavoritesCoordinatorSpy,
        storageSpy: GistFavoritesStorageProviderSpy
    ) {
        let coordinatorSpy = GistFavoritesCoordinatorSpy()
        let storageSpy = GistFavoritesStorageProviderSpy()
        let sut = GistFavoritesViewModel(coordinator: coordinatorSpy, storage: storageSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(coordinatorSpy)
        trackForMemoryLeaks(storageSpy)

        return (sut, coordinatorSpy, storageSpy)
    }

    private func makeError() -> NSError {
        return NSError(domain: "any-domain", code: 0)
    }
}
