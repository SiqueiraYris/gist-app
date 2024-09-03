import XCTest
@testable import GistKit

final class GistListCoordinatorTests: XCTestCase {
    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, _, _) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertNotNil(viewController.isBeingPresented)
    }

    func test_openFavorites_shouldOpenFavoritesCorrectly() {
        let expectedURL = URL(string: "gist-app://favorites")!
        let (sut, navigator, routingHubSpy) = makeSUT()

        sut.openFavorites()

        XCTAssertEqual(routingHubSpy.receivedMessages, [.start(
            url: expectedURL, 
            navigation: navigator
        )])
    }

    func test_openDetails_shouldOpenDetailsCorrectly() {
        let expectedURL = URL(string: "gist-app://gist-detail")!
        let (sut, navigator, routingHubSpy) = makeSUT()

        sut.openDetails(with: nil)

        XCTAssertEqual(routingHubSpy.receivedMessages, [.start(
            url: expectedURL,
            navigation: navigator
        )])
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistListCoordinator,
        navigator: UINavigationController,
        routingHubSpy: RoutingHubSpy
    ) {
        let navigator = UINavigationController()
        let routingHubSpy = RoutingHubSpy()
        let sut = GistListCoordinator(navigator: navigator, router: routingHubSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)
        trackForMemoryLeaks(routingHubSpy)

        return (sut, navigator, routingHubSpy)
    }
}
