import Foundation

public struct DefaultItemData {
    public let title: String?
    public let subtitle: String?
    public let image: String?
    public let imageData: Data?

    public init(
        title: String? = nil, 
        subtitle: String? = nil, 
        image: String? = nil,
        imageData: Data? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.imageData = imageData
    }
}
