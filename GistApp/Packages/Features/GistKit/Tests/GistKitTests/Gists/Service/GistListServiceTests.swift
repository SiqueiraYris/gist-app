import XCTest
import NetworkKit
@testable import GistKit

final class GistListServiceTests: XCTestCase {
    func test_request_shouldReceiveSuccess() {
        let (sut, manager) = makeSUT()
        let response = [GistItemResponse.fixture()]
        let result: GistListResult = .success(response)

        sut.fetch(GistListServiceRoute.fetchGist(page: 0)) { _ in }
        manager.completeWithSuccess(result: result)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    func test_request_shouldReceiveFailure() {
        let (sut, manager) = makeSUT()
        let error = ResponseError.fixture()
        let result: GistListResult = .failure(error)

        sut.fetch(GistListServiceRoute.fetchGist(page: 0)) { _ in }
        manager.completeWithError(error: error)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: GistListService,
                               networkManager: GistListNetworkManagerSpy) {
        let spy = GistListNetworkManagerSpy()
        let sut = GistListService(manager: spy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }
}
