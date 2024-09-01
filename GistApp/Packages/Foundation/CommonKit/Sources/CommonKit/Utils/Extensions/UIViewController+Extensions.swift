import UIKit

public extension UIViewController {
    func setupBackButton(color: UIColor) {
        let imgBack = UIImage(named: "ic_back")
        navigationController?.navigationBar.backIndicatorImage = imgBack
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = imgBack
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "", 
            style: .plain,
            target: self,
            action: nil
        )
        navigationController?.navigationBar.tintColor = color
    }
}
