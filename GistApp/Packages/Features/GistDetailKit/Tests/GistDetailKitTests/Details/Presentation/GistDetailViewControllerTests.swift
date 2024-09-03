import XCTest
@testable import GistDetailKit

final class GistDetailViewControllerTests: XCTestCase {
    func test_viewDidLoad_triggersFetch() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistDetailViewController,
        viewModelSpy: GistDetailViewModelSpy
    ) {
        let viewModelSpy = GistDetailViewModelSpy()
        let sut = GistDetailViewController(viewModel: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }
}
