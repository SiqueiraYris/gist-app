import UIKit
import ComponentsKit

final class GistListViewController: UIViewController {
    // MARK: - Views

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DefaultItemCell.self, forCellReuseIdentifier: DefaultItemCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.primaryLight
        return refreshControl
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

    private let informationView: InformationStateView = {
        let view = InformationStateView()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigation()
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Colors.background
        title = Strings.navigationTitle

        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(informationView)
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

            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Spacings.lg),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Spacings.lg),
            informationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupNavigation() {
        setupNavigationBar(prefersLargeTitles: true)

        let buttonItem = UIBarButtonItem(
            title: Strings.favoritesButtonTitle,
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
            self.informationView.isHidden = true

            if !isLoading {
                self.refreshControl.endRefreshing()
            }
        }

        viewModel.shouldReloadData.bind { [weak self] isLoading in
            self?.informationView.isHidden = true
            self?.tableView.reloadData()
        }

        viewModel.error.bind { [weak self] errorMessage in
            guard let self = self else { return }

            if let errorMessage = errorMessage {
                self.showInformationState(with: errorMessage)
            }
        }
    }

    private func showInformationState(with message: String) {
        informationView.isHidden = false
        informationView.setup(
            title: Strings.errorTitle,
            subtitle: message,
            buttonText: Strings.errorFavoriteButtonTitle
        ) { [weak self] in
            self?.viewModel.openFavorites()
        }
    }

    // MARK: - Actions

    @objc private func didTapFavoriteButton() {
        viewModel.openFavorites()
    }

    @objc private func didPullToRefresh() {
        viewModel.resetPagination()
        viewModel.fetch()
    }
}

// MARK: - UITableViewDataSource

extension GistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DefaultItemCell.reuseIdentifier,
            for: indexPath
        ) as? DefaultItemCell else {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(row: indexPath.row)
    }

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
