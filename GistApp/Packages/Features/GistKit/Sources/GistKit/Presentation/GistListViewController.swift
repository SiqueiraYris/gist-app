import UIKit
import ComponentsKit

final class GistListViewController: UIViewController {
    // MARK: - Views

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GistCell.self, forCellReuseIdentifier: GistCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Properties

    private let viewModel: GistListViewModelProtocol

    // MARK: - Initializer

    init(viewModel: GistListViewModelProtocol) {
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
        title = "Gists"

        tableView.dataSource = self
        tableView.delegate = self

        setupViewHierarchy()
        setupViewConstraints()
        setupNavigation()
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacings.sm),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.sm),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.sm),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.sm)
        ])
    }

    private func setupNavigation() {
        let buttonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapFavoriteButton)
        )
        buttonItem.tintColor = Colors.primaryLight

        navigationItem.rightBarButtonItem = buttonItem
    }

    @objc private func didTapFavoriteButton() { 
        viewModel.openFavorites()
    }
}

// MARK: - UITableViewDataSource

extension GistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GistCell.reuseIdentifier,
            for: indexPath
        ) as? GistCell else {
            return UITableViewCell()
        }

        cell.setupData(title: "Title", subtitle: "Subtitle")

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
}

// MARK: - UITableViewDelegate

extension GistListViewController: UITableViewDelegate {}
