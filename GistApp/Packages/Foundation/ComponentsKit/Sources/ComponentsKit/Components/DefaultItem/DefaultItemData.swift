import Foundation

public struct DefaultItemData {
    let title: String?
    let subtitle: String?
    let image: String?
    let imageData: Data?

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
