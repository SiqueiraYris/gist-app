import XCTest
import CommonKit

final class DictionaryExtensionTests: XCTestCase {
    func test_toModel_shouldReturnCorrectModel() {
        let dictionary: [AnyHashable: Any] = [
            "id": 1,
            "name": "John Doe",
            "email": "john.doe@example.com"
        ]

        let userModel = dictionary.toModel(UserModel.self)

        XCTAssertNotNil(userModel)
        XCTAssertEqual(userModel?.id, 1)
        XCTAssertEqual(userModel?.name, "John Doe")
        XCTAssertEqual(userModel?.email, "john.doe@example.com")
    }

    func test_toModel_shouldReturnNilForInvalidDictionary() {
        let dictionary: [AnyHashable: Any] = [
            "id": "invalid_id",
            "name": "John Doe",
            "email": "john.doe@example.com"
        ]

        let userModel = dictionary.toModel(UserModel.self)

        XCTAssertNil(userModel)
    }
}
