import UIKit
import ComponentsKit

final class GistDetailViewController: UIViewController {
    // MARK: - Views

    private let avatar = Avatar()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = Colors.gray_100
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Properties

    private let viewModel: GistDetailViewModelProtocol

    // MARK: - Initializer

    init(viewModel: GistDetailViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Colors.background

        setupViewHierarchy()
        setupViewConstraints()
        setupBindings()
    }

    private func setupViewHierarchy() {
        view.addSubview(avatar)
        view.addSubview(titleLabel)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacings.md),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Spacings.md),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.sm),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.sm)
        ])
    }

    private func setupBindings() {
        titleLabel.text = viewModel.getUserName()
        if let url = viewModel.getAvatar(), let imageURL = URL(string: url) {
            avatar.download(from: imageURL)
        }
    }
}
