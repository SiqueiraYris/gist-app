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

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = Colors.primaryLight
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let footerLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = Colors.primaryLight
        indicator.startAnimating()
        return indicator
    }()

    private let emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel.fetch()
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Colors.background
        title = Strings.navigationTitle

        tableView.dataSource = self
        tableView.delegate = self

        setupViewHierarchy()
        setupViewConstraints()
        setupNavigation()
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(emptyStateView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, 
                                           constant: Spacings.sm),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Spacings.sm),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Spacings.sm),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                              constant: -Spacings.sm),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Spacings.lg),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Spacings.lg),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            self.loadingIndicator.isHidden = !isLoading
            isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
        }

        viewModel.shouldReloadData.bind { [weak self] isLoading in
            self?.tableView.reloadData()
        }

        viewModel.error.bind { [weak self] errorMessage in
            guard let self = self else { return }

            if let errorMessage = errorMessage {
                self.showEmptyState(with: errorMessage)
            }
        }
    }

    private func showEmptyState(with message: String) {
        emptyStateView.isHidden = false
        emptyStateView.setup(message: message) { [weak self] in
            self?.viewModel.openFavorites()
        }
    }

    // MARK: - Actions

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

        cell.setupData(data: viewModel.cellForRowAt(row: indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
}

// MARK: - UITableViewDelegate

extension GistListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if position > (contentHeight - scrollViewHeight - 100) && !viewModel.isLoading.value {
            tableView.tableFooterView = footerLoadingIndicator
            viewModel.fetch()
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !viewModel.isLoading.value {
            tableView.tableFooterView = nil
        }
    }
}
