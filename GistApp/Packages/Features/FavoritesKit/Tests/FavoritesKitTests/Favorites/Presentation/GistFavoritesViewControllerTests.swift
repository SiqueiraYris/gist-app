import XCTest
import ComponentsKit
@testable import FavoritesKit

final class GistFavoritesViewControllerTests: XCTestCase {
    func test_viewWillAppear_triggersFetch() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.fetch])
    }

    func test_shouldReloadData_bindingReloadsTableView() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()
        let tableView = sut.view.subviews.compactMap { $0 as? UITableView }.first!

        viewModelSpy.shouldReloadData.value = true

        XCTAssertTrue(tableView.isReloadingData)
    }

    func test_error_bindingShowsInformationState() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        viewModelSpy.error.value = "Some Error"

        XCTAssertFalse(sut.view.subviews.compactMap { $0 as? InformationStateView }.first!.isHidden)
    }

    func test_showToast_bindingShowsToast() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        viewModelSpy.showToast.value = true

        XCTAssertTrue(sut.view.subviews.contains { $0 is ToastView })
    }

    func test_showInformationState_bindingShowsEmptyState() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        viewModelSpy.showInformationState.value = true

        let informationView = sut.view.subviews.compactMap { $0 as? InformationStateView }.first!
        XCTAssertFalse(informationView.isHidden)
    }

    func test_tableViewDelegatesConfigured() {
        let (sut, _) = makeSUT()

        sut.loadViewIfNeeded()

        let tableView = sut.view.subviews.compactMap { $0 as? UITableView }.first!

        XCTAssertTrue(tableView.dataSource === sut)
        XCTAssertTrue(tableView.delegate === sut)
    }

    func test_numberOfRowsInSection_callsViewModel() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        _ = sut.tableView(sut.view.subviews.compactMap { $0 as? UITableView }.first!, numberOfRowsInSection: 0)

        XCTAssertEqual(viewModelSpy.receivedMessages, [.numberOfRowsInSection(section: 0)])
    }

    func test_cellForRowAt_callsViewModel() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        let tableView = sut.view.subviews.compactMap { $0 as? UITableView }.first!
        _ = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(viewModelSpy.receivedMessages, [.cellForRowAt(row: 0)])
    }

    func test_didSelectRowAt_callsViewModel() {
        let (sut, viewModelSpy) = makeSUT()

        sut.loadViewIfNeeded()

        let tableView = sut.view.subviews.compactMap { $0 as? UITableView }.first!
        sut.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        XCTAssertEqual(viewModelSpy.receivedMessages, [.didSelectRowAt(row: 0)])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistFavoritesViewController,
        viewModelSpy: GistFavoritesViewModelSpy
    ) {
        let viewModelSpy = GistFavoritesViewModelSpy()
        let sut = GistFavoritesViewController(viewModel: viewModelSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(viewModelSpy)

        return (sut, viewModelSpy)
    }
}
