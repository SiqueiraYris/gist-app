import XCTest
@testable import GistDetailKit

final class GistDetailCoordinatorTests: XCTestCase {
    func test_start_shouldStartSceneCorrectly() {
        let viewController = UIViewController()
        let (sut, _) = makeSUT()

        sut.start(viewController: viewController)

        XCTAssertNotNil(viewController.isBeingPresented)
    }

    // MARK: - Helpers

    private func makeSUT() -> (
        sut: GistDetailCoordinator,
        navigator: UINavigationController
    ) {
        let navigator = UINavigationController()
        let sut = GistDetailCoordinator(navigator: navigator)

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(navigator)

        return (sut, navigator)
    }
}
