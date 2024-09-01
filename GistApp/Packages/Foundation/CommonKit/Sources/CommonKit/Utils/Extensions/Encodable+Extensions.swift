import Foundation

public extension Encodable {
    func toDictionary() -> [AnyHashable: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let dictionary = json as? [String: Any] else { return nil }

        return dictionary.reduce(into: [AnyHashable: Any]()) { (result, item) in
            result[item.key] = item.value
        }
    }
}
