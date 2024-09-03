import XCTest
import CommonKit

final class CollectionExtensionTests: XCTestCase {
    func test_safeSubscript_withValidIndex_shouldReturnElement() {
        let array = [1, 2, 3, 4, 5]

        let element = array[safe: 2]

        XCTAssertNotNil(element)
        XCTAssertEqual(element, 3)
    }

    func test_safeSubscript_withInvalidIndex_shouldReturnNil() {
        let array = [1, 2, 3, 4, 5]

        let element = array[safe: 10]

        XCTAssertNil(element)
    }

    func test_safeSubscript_withEmptyCollection_shouldReturnNil() {
        let emptyArray: [Int] = []

        let element = emptyArray[safe: 0]

        XCTAssertNil(element)
    }
}
