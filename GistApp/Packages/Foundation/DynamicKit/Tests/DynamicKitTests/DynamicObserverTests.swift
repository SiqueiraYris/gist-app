import XCTest
@testable import DynamicKit

final class DynamicObserverTests: XCTestCase {
    func test_init_whenInitializationIsEmpty_shouldDeliversEmptyValues() {
        let observer = DynamicObserver<String>()

        XCTAssertTrue(observer.values.isEmpty)
    }

    func test_addValue_whenAddOneValue_shouldDeliversOneValue() {
        let observer = DynamicObserver<String>()

        observer.addValue("First")

        XCTAssertEqual(observer.values, ["First"])
    }

    func test_addValue_whenAddMultipleValue_shouldDeliversAllValues() {
        let observer = DynamicObserver<String>()

        observer.addValue("First")
        observer.addValue("Second")
        observer.addValue("Third")

        XCTAssertEqual(observer.values, ["First", "Second", "Third"])
    }

    func test_addValue_whenObserverIsInt_shouldDeliversIntValue() {
        let intObserver = DynamicObserver<Int>()

        intObserver.addValue(1)
        intObserver.addValue(2)

        XCTAssertEqual(intObserver.values, [1, 2])
    }

    func test_addValue_whenObserverIsDouble_shouldDeliversDoubleValue() {
        let doubleObserver = DynamicObserver<Double>()

        doubleObserver.addValue(1.1)
        doubleObserver.addValue(2.2)

        XCTAssertEqual(doubleObserver.values, [1.1, 2.2])
    }

    func test_addValue_whenObserverIsBoolean_shouldDeliversBooleanValue() {
        let doubleObserver = DynamicObserver<Bool>()

        doubleObserver.addValue(false)
        doubleObserver.addValue(true)

        XCTAssertEqual(doubleObserver.values, [false, true])
    }
}
