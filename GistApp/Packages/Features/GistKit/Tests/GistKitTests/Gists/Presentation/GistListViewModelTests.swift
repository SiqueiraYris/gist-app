import XCTest
import DynamicKit
import NetworkKit
@testable import GistKit

final class GistListViewModelTests: XCTestCase {
    func test_fetch_shouldFetchDataWithSuccess() {
        let response = [GistItemResponse.fixture()]
        let result: GistListResult = .success(response)
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = result
        sut.fetch()
        serviceSpy.completeWithSuccess(object: response)

        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertNil(sut.error.value)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), response.count)
        XCTAssertEqual(serviceSpy.receivedMessages, [.fetch(route: .fetchGist(page: 0))])
    }

    func test_fetch_shouldFetchDataWithError() {
        let error = ResponseError.fixture()
        let result: GistListResult = .failure(error)
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = result
        sut.fetch()
        serviceSpy.completeWithError(error: error)

        XCTAssertFalse(sut.shouldReloadData.value)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.error.value, error.errorDescription)
        XCTAssertEqual(serviceSpy.receivedMessages, [.fetch(route: .fetchGist(page: 0))])
    }

    func test_retryLastFetch_shouldRetryFetchingDataAfterFailure() {
        let error = ResponseError.fixture()
        let response = [GistItemResponse.fixture()]
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = .failure(error)
        sut.fetch()
        serviceSpy.completeWithError(error: error)

        XCTAssertTrue(sut.error.value != nil)

        serviceSpy.result = .success(response)
        sut.retryLastFetch()
        serviceSpy.completeWithSuccess(object: response)

        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertFalse(sut.isLoading.value)
        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), response.count)
    }

    func test_resetPagination_shouldResetStateAndReloadData() {
        let response = [GistItemResponse.fixture()]
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = .success(response)
        sut.fetch()
        sut.resetPagination()
        serviceSpy.completeWithSuccess(object: response)

        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), 0)
        XCTAssertTrue(sut.shouldReloadData.value)
        XCTAssertFalse(sut.isLoading.value)
    }

    func test_numberOfRowsInSection_shouldReturnCorrectNumberOfRows() {
        let response = [GistItemResponse.fixture(), GistItemResponse.fixture()]
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = .success(response)
        sut.fetch()
        serviceSpy.completeWithSuccess(object: response)

        XCTAssertEqual(sut.numberOfRowsInSection(section: 0), response.count)
    }

    func test_cellForRowAt_shouldReturnCorrectCellData() {
        let item = GistItemResponse.fixture()
        let response = [item]
        let (sut, serviceSpy, _) = makeSUT()

        serviceSpy.result = .success(response)
        sut.fetch()
        serviceSpy.completeWithSuccess(object: response)

        let cellData = sut.cellForRowAt(row: 0)

        XCTAssertEqual(cellData?.title, "Usuário: \(item.owner.userName)")
        XCTAssertEqual(cellData?.subtitle, "Qt de arquivos: \(item.files.count)")
        XCTAssertEqual(cellData?.image, item.owner.avatarURL)
    }

    func test_didSelectRowAt_shouldTriggerNavigationToDetails() {
        let item = GistItemResponse.fixture()
        let response = [item]
        let (sut, serviceSpy, coordinatorSpy) = makeSUT()

        serviceSpy.result = .success(response)
        sut.fetch()
        serviceSpy.completeWithSuccess(object: response)

        sut.didSelectRowAt(row: 0)

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openDetails])
    }

    func test_openFavorites_shouldTriggerNavigationToFavorites() {
        let (sut, _, coordinatorSpy) = makeSUT()

        sut.openFavorites()

        XCTAssertEqual(coordinatorSpy.receivedMessages, [.openFavorites])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistListViewModel,
        serviceSpy: GistListServiceSpy,
        coordinatorSpy: GistListCoordinatorSpy
    ) {
        let serviceSpy = GistListServiceSpy()
        let coordinatorSpy = GistListCoordinatorSpy()
        let sut = GistListViewModel(coordinator: coordinatorSpy, service: serviceSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(serviceSpy)
        trackForMemoryLeaks(coordinatorSpy)

        return (sut, serviceSpy, coordinatorSpy)
    }
}
