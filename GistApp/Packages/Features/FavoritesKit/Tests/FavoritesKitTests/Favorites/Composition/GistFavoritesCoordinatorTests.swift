import XCTest
@testable import FavoritesKit

final class GistFavoritesCoordinatorTests: XCTestCase {
    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, _, _) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertNotNil(viewController.isBeingPresented)
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
        sut: GistFavoritesCoordinator,
        navigator: UINavigationController,
        routingHubSpy: RoutingHubSpy
    ) {
        let navigator = UINavigationController()
        let routingHubSpy = RoutingHubSpy()
        let sut = GistFavoritesCoordinator(navigator: navigator, router: routingHubSpy)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)
        trackForMemoryLeaks(routingHubSpy)

        return (sut, navigator, routingHubSpy)
    }
}
