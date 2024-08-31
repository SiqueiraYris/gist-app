import XCTest
import RouterKit

final class RoutingHubTests: XCTestCase {
    func test_descriptors_whenDescriptorsAreEmpty_shouldDeliversEmptyResult() {
        let scheme = "any-scheme"
        let sut = makeSUT(scheme: scheme)

        let descriptors = sut.descriptors

        XCTAssertEqual(descriptors.count, 0)
    }

    func test_descriptors_whenDescriptorsAreSet_shouldDeliversCorrectResult() {
        let routeDescriptorSpy = RouteDescriptorSpy()
        let scheme = "any-scheme"
        let sut = makeSUT(scheme: scheme)

        sut.descriptors = [routeDescriptorSpy]
        let descriptors = sut.descriptors

        XCTAssertEqual(descriptors.count, 1)
    }

    func test_rootViewController_whenRootNavigatorAreEmpty_shouldDeliversEmptyResult() {
        let scheme = "any-scheme"
        let sut = makeSUT(scheme: scheme)

        let rootViewController = sut.rootViewController

        XCTAssertNil(rootViewController)
    }

    func test_rootViewController_whenRootNavigatorIsSet_shouldDeliversCorrectResult() {
        let navigator = UINavigationController()
        let scheme = "any-scheme"
        let sut = makeSUT(scheme: scheme)

        sut.rootViewController = navigator
        let rootViewController = sut.rootViewController

        XCTAssertNotNil(rootViewController)
    }

    func test_register_shouldDeliversCorrectResult() {
        let routeDescriptorSpy = RouteDescriptorSpy()
        let scheme = "any-scheme"
        let url = URL(string: "\(scheme)://any-url")!
        let sut = makeSUT(scheme: scheme)

        sut.register(descriptor: routeDescriptorSpy)

        XCTAssertEqual(sut.descriptors.count, 1)
    }

    func test_startOnNavigation_whenDescriptorsAreSetAndURLMatches_shouldDeliversCorrectResult() {
        let navigator = UINavigationController()
        let routeDescriptorSpy = RouteDescriptorSpy()
        let scheme = "any-scheme"
        let url = URL(string: "\(scheme)://any-url")!
        let sut = makeSUT(scheme: scheme)

        routeDescriptorSpy.valueToBeReturned = true
        sut.register(descriptor: routeDescriptorSpy)
        sut.start(url: url, on: navigator)

        XCTAssertEqual(routeDescriptorSpy.receivedMessages, [.match(url: url),
                                                             .startWithNavigationController(url: url, navigator: navigator)])
    }

    func test_startOnNavigation_whenDescriptorsAreSetAndURLNotMatches_shouldDeliversCorrectResult() {
        let navigator = UINavigationController()
        let routeDescriptorSpy = RouteDescriptorSpy()
        let scheme = "any-scheme"
        let url = URL(string: "\(scheme)://any-url")!
        let sut = makeSUT(scheme: scheme)

        routeDescriptorSpy.valueToBeReturned = false
        sut.register(descriptor: routeDescriptorSpy)
        sut.start(url: url, on: navigator)

        XCTAssertEqual(routeDescriptorSpy.receivedMessages, [.match(url: url)])
    }

    // MARK: - Helpers

    private func makeSUT(scheme: String) -> RoutingHub {
        let sut = RoutingHub(scheme: scheme)
        trackForMemoryLeaks(sut)
        return sut
    }
}
