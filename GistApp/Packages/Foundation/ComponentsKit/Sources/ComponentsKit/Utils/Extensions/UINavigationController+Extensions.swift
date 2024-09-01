import UIKit

public extension UIViewController {
    func setupNavigationBar(prefersLargeTitles: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.background
        appearance.titleTextAttributes = [.foregroundColor: Colors.primaryLight]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: Colors.primaryLight,
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]

        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
