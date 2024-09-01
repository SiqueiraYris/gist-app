import Foundation

public enum ServiceResult {
    case success(Decodable)
    case failure(ResponseError)
}

public struct DefaultResultMapper {
    public static func map<T: Decodable>(_ data: Data, to type: T.Type) -> ServiceResult {
        guard let data = try? JSONDecoder().decode(type.self, from: data) else {
            return .failure(ResponseError(defaultError: .decoderFailure))
        }

        return .success(data)
    }
}
