import XCTest
import CommonKit

final class EncodableExtensionTests: XCTestCase {
    func test_toDictionary_shouldReturnCorrectDictionary() {
        let userModel = UserModel(id: 1, name: "John Doe", email: "john.doe@example.com")

        let dictionary = userModel.toDictionary()

        XCTAssertNotNil(dictionary)
        XCTAssertEqual(dictionary?["id"] as? Int, 1)
        XCTAssertEqual(dictionary?["name"] as? String, "John Doe")
        XCTAssertEqual(dictionary?["email"] as? String, "john.doe@example.com")
    }
}
