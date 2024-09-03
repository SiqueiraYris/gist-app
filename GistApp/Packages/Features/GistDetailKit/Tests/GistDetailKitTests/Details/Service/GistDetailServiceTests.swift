import Foundation
import XCTest
import NetworkKit
@testable import GistDetailKit

final class GistDetailServiceTests: XCTestCase {
    func test_request_whenTheContentIsExpectedData_shouldReceiveSuccess() {
        let (sut, manager) = makeSUT()
        let text = "any-text"
        let result: GistDetailResult = .success(text)

        manager.result = .success(makeGistData(text: text))
        sut.fetch(GistDetailServiceRoute.fetchDetail(request: makeGistDetailRequest())) { _ in }
        manager.completeWithSuccess(result: result)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    func test_request_whenTheContentIsAnyData_shouldReceiveError() {
        let (sut, manager) = makeSUT()
        let error = ResponseError.fixture()
        let result: GistDetailResult = .failure(error)

        manager.result = .success(makeAnyData())
        sut.fetch(GistDetailServiceRoute.fetchDetail(request: makeGistDetailRequest())) { _ in }
        manager.completeWithError(error: error)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    func test_request_shouldReceiveFailure() {
        let (sut, manager) = makeSUT()
        let error = ResponseError.fixture()
        let result: GistDetailResult = .failure(error)

        manager.result = .failure(error)
        sut.fetch(GistDetailServiceRoute.fetchDetail(request: makeGistDetailRequest())) { _ in }
        manager.completeWithError(error: error)

        XCTAssertEqual(manager.receivedMessages, [.request(result: result)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (sut: GistDetailService,
                               networkManager: NetworkManagerSpy) {
        let spy = NetworkManagerSpy()
        let sut = GistDetailService(manager: spy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(spy)

        return (sut, spy)
    }

    private func makeGistData(text: String) -> Data {
        return text.data(using: .utf8)!
    }

    private func makeAnyData() -> Data {
        return Data()
    }

    private func makeGistDetailRequest() -> GistDetailRequest {
        return GistDetailRequest(host: "any-host", path: "any=path")
    }
}
