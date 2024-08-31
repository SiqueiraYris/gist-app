public final class DynamicObserver<T> {
    private(set) var values: [T] = []

    public init() { }

    public func addValue(_ value: T) {
        values.append(value)
    }
}
