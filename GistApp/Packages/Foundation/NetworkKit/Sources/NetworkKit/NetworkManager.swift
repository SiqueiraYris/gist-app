import Foundation

public final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSessionProtocol
    private let queue: DispatchQueueProtocol

    public static var shared = NetworkManager()

    init(
        session: URLSessionProtocol = URLSession.shared,
        queue: DispatchQueueProtocol = DispatchQueue.main
    ) {
        self.session = session
        self.queue = queue
    }

    public func request(with config: RequestConfigProtocol, completion: @escaping (ResponseResult) -> Void) {
        guard let urlRequest = config.createUrlRequest() else {
            completion(.failure(ResponseError(defaultError: NetworkError.malformedUrl)))
            return
        }

        curl(from: urlRequest, debug: config.debugMode)

        let task = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }

            self.queue.async {
                do {
                    if let nsError = error as NSError? {
                        try ResponseMapper.map(nsError)
                    }

                    guard let httpURLResponse = response as? HTTPURLResponse else { throw NetworkError.unknownFailure }
                    try ResponseMapper.map(httpURLResponse.statusCode)

                    guard let data = data else {
                        throw NetworkError.noData
                    }

                    self.checkPrintDebugData(title: "Decoding",
                                             debug: config.debugMode,
                                             url: urlRequest.url?.absoluteString,
                                             data: data,
                                             curl: urlRequest.curlString)

                    completion(.success(data))
                } catch let error as NetworkError {
                    self.genericCatchError(urlRequest: urlRequest, data: data, error: error, config: config, completion: completion)
                } catch let error as NetworkError.HTTPErrors {
                    self.genericCatchError(urlRequest: urlRequest, data: data, error: error, config: config, completion: completion)
                } catch {
                    self.genericCatchError(urlRequest: urlRequest, data: data, error: NetworkError.unknownFailure, config: config, completion: completion)
                }
            }
        }
        task.resume()
    }
}

extension NetworkManager {
    private func curl(from urlRequest: URLRequest, debug: Bool) {
        if debug {
            print("---------------------------------------------------------------")
            print("---------------------------------------------------------------")
            guard let url = urlRequest.url else { return }
            var baseCommand = #"curl "\#(url.absoluteString)""#
            if urlRequest.httpMethod == "HEAD" {
                baseCommand += " --head"
            }

            var command = [baseCommand]
            if let method = urlRequest.httpMethod, method != "GET" && method != "HEAD" {
                command.append("-X \(method)")
            }

            if let headers = urlRequest.allHTTPHeaderFields {
                for (key, value) in headers where key != "Cookie" {
                    command.append("-H '\(key): \(value)'")
                }
            }

            if let data = urlRequest.httpBody, let body = String(data: data, encoding: .utf8) {
                command.append("-d '\(body)'")
            }

            print(command.joined(separator: " \\\n\t"))
        }
    }

    private func checkPrintDebugData(title: String, debug: Bool, url: String?, data: Data?, curl: String?) {
        if debug {
            printDebugData(title: title, url: url, data: data, curl: curl)
        }
    }

    private func genericCatchError<R>(urlRequest: URLRequest,
                                      data: Data?, 
                                      error: R,
                                      config: RequestConfigProtocol,
                                      completion: @escaping (ResponseResult) -> Void) where R: NetworkErrorProtocol {
        if config.debugMode {
            printDebugData(title: String(describing: R.self),
                           url: urlRequest.url?.absoluteString,
                           data: data,
                           curl: urlRequest.curlString)
        }
        completion(.failure(ResponseError(statusCode: error.code,
                                          defaultError: error)))
    }

    /// With this code you can get curl and put this code in postman to test
    private func printDebugData(title: String, url: String?, data: Data?, curl: String?) {
        print("---------------------------------------------------------------")
        print("🔬 - DEBUG MODE ON FOR: \(title) - 🔬")
        print("📡 URL: \(url ?? "No URL passed")")
        print(data?.toString() ?? "No Data passed")
        print(curl ?? "No curl command passed")
        print("---------------------------------------------------------------")
    }
}
