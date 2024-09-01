import UIKit
import ComponentsKit

final class GistFavoritesViewController: UIViewController {
    // MARK: - Views

    // MARK: - Properties

    private let viewModel: GistFavoritesViewModelProtocol

    // MARK: - Initializer

    init(viewModel: GistFavoritesViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigation()
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Colors.background
        title = Strings.navigationTitle

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() { }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([])
    }

    private func setupNavigation() {
        setupBackButton()
        setupNavigationBar(prefersLargeTitles: false)
    }
}
