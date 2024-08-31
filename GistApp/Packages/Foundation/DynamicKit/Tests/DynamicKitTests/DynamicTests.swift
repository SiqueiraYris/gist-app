import XCTest
@testable import DynamicKit

final class DynamicTests: XCTestCase {
    func test_init_whenValueHasNotChange_shouldKeepsInitialValue() {
        let value = false
        let dynamicValue = Dynamic(value)

        XCTAssertEqual(dynamicValue.value, value)
    }

    func test_value_whenValueIsSet_shouldDeliversCorrectValue() {
        let expectedValue = false
        let dynamicValue = Dynamic(true)

        dynamicValue.value = expectedValue

        XCTAssertEqual(expectedValue, dynamicValue.value)
    }

    func test_listener_shouldCallsListenerOnValueUpdate() {
        let initialValue = "Initial"
        let expectedValue = "Updated"
        let dynamic = Dynamic(initialValue)

        var hasCalledListener = false
        dynamic.bind { value in
            hasCalledListener = true
            XCTAssertEqual(value, expectedValue)
        }

        dynamic.value = expectedValue
        XCTAssertTrue(hasCalledListener)
    }

    func test_bind_shouldCallsListenerOnMainThread() {
        let initialValue = "Initial"
        let expectedValue = "Updated"
        let dynamic = Dynamic(initialValue)
        let expectation = expectation(description: "Listener called on main thread")

        dynamic.bind { _ in
            XCTAssertTrue(Thread.isMainThread)
            expectation.fulfill()
        }

        DispatchQueue.global().async {
            dynamic.value = expectedValue
            XCTAssertEqual(dynamic.value, expectedValue)
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
