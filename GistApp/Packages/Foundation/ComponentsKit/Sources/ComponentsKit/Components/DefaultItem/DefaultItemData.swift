public struct DefaultItemData {
    let title: String?
    let subtitle: String?
    let image: String?

    public init(
        title: String? = nil, 
        subtitle: String? = nil, 
        image: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}
