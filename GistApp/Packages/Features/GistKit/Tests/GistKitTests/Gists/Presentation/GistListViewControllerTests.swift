import XCTest
import ComponentsKit
@testable import GistKit

final class GistListViewControllerTests: XCTestCase {
    func test_viewDidLoad_shouldTriggersViewModelCorrectly() {
        let (sut, viewModelSpy) = makeSUT()

        _ = sut

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch])
    }

    func test_didSelectRow_shouldTriggersViewModelSelection() {
        let dummyTableView = makeUITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let (sut, viewModelSpy) = makeSUT()

        sut.tableView(dummyTableView, didSelectRowAt: indexPath)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .didSelectRowAt(row: 0)])
    }

    func test_numberOfRowsInSection_shouldTriggersViewModelCorrectly() {
        let dummyTableView = makeUITableView()
        let expectedNumberOfRows = 2
        let (sut, viewModelSpy) = makeSUT()

        viewModelSpy.numberOfRowsInSectionToBeReturned = expectedNumberOfRows
        let numberOfRowsInSection = sut.tableView(dummyTableView, numberOfRowsInSection: 0)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .numberOfRowsInSection(section: 0)])
        XCTAssertEqual(numberOfRowsInSection, expectedNumberOfRows)
    }

    func test_cellForRowAt_shouldTriggersViewModelCorrectly() {
        let dummyTableView = makeUITableView()
        let indexPath = IndexPath(row: 0, section: 0)
        let (sut, viewModelSpy) = makeSUT()

        viewModelSpy.defaultItemDataToBeReturned = makeDefaultItemData()
        let cell = sut.tableView(dummyTableView, cellForRowAt: indexPath)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
            .cellForRowAt(row: 0)])
        XCTAssertTrue(cell is DefaultItemCell)
    }

    func test_scrollViewDidScroll_shouldTriggersViewModelCorrectly() {
        let dummyScrollView = UIScrollView()
        let (sut, viewModelSpy) = makeSUT()

        sut.scrollViewDidScroll(dummyScrollView)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .numberOfRowsInSection(section: 0),
                                                       .fetch])
    }

    func test_scrollViewDidEndDragging_shouldTriggersViewModelCorrectly() {
        let dummyScrollView = UIScrollView()
        let (sut, viewModelSpy) = makeSUT()

        sut.scrollViewDidEndDragging(dummyScrollView, willDecelerate: false)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch,
                                                       .numberOfRowsInSection(section: 0)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistListViewController,
        viewModelSpy: GistListViewModelSpy
    ) {
        let viewModelSpy = GistListViewModelSpy()
        let sut = GistListViewController(viewModel: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }

    private func makeDefaultItemData() -> DefaultItemData? {
        return DefaultItemData(
            title: "any-title",
            subtitle: "any-subtitle",
            image: "any-image"
        )
    }

    private func makeUITableView() -> UITableView {
        let dummyTableView = UITableView()
        dummyTableView.register(DefaultItemCell.self, forCellReuseIdentifier: DefaultItemCell.reuseIdentifier)
        return dummyTableView
    }
}
