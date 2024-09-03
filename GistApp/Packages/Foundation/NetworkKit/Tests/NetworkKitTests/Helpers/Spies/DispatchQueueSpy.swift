import NetworkKit

final class DispatchQueueSpy: DispatchQueueProtocol {
    enum Messages: Equatable {
        case async
    }

    var receivedMessages: [Messages] = []

    func async(execute work: @escaping () -> Void) {
        receivedMessages.append(.async)
        work()
    }
}
