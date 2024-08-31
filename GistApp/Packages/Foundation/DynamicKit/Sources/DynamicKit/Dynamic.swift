import Foundation

public final class Dynamic<T> {
    public typealias Listener = (T) -> Void

    private var listener: Listener?
    private var observer: DynamicObserver<T>?

    public var value: T {
        didSet {
            observer?.addValue(value)
            callListener()
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func bind(listener: Listener?) {
        self.listener = listener
    }

    private func callListener() {
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
}
