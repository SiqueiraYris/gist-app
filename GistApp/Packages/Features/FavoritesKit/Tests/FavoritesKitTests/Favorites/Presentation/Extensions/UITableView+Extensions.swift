import UIKit

extension UITableView {
    var isReloadingData: Bool {
        return numberOfSections > 0
    }
}
