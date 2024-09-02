import UIKit
import ComponentsKit

final class GistFavoritesViewController: UIViewController {
    // MARK: - Views

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DefaultItemCell.self, forCellReuseIdentifier: DefaultItemCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let informationView: InformationStateView = {
        let view = InformationStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

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

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        view.addSubview(tableView)
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

            informationView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: Spacings.lg),
            informationView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -Spacings.lg),
            informationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupNavigation() {
        setupBackButton()
        setupNavigationBar(prefersLargeTitles: true)

        let buttonItem = UIBarButtonItem(
            title: Strings.clearFavoritesTitle,
            style: .plain,
            target: self,
            action: #selector(didTapClearButton)
        )
        buttonItem.tintColor = Colors.primaryLight

        navigationItem.rightBarButtonItem = buttonItem
    }

    private func setupBindings() {
        viewModel.shouldReloadData.bind { [weak self] _ in
            self?.tableView.reloadData()
        }

        viewModel.error.bind { [weak self] errorMessage in
            guard let self = self else { return }

            if let errorMessage = errorMessage {
                self.showInformationState(with: errorMessage)
            }
        }

        viewModel.showToast.bind { [weak self] _ in
            self?.showToast()
        }
    }

    private func showInformationState(with message: String) {
        informationView.isHidden = false
        informationView.setup(
            title: Strings.errorTitle,
            subtitle: message,
            buttonText: Strings.tryAgainButtonTitle
        ) { [weak self] in
            self?.viewModel.fetch()
        }
    }

    private func showToast() {
        let toast = ToastView(text: Strings.deleteToastText)
        toast.show(in: view)
    }

    // MARK: - Actions

    @objc private func didTapClearButton() {
        viewModel.clearFavorites()
    }
}

// MARK: - UITableViewDataSource

extension GistFavoritesViewController: UITableViewDataSource {
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
