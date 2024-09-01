import Foundation

public extension Dictionary where Key == AnyHashable, Value == Any {
    func toModel<T: Decodable>(_ type: T.Type) -> T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }
}
