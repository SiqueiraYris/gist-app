import UIKit
import CommonKit
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

    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Colors.gray_300.cgColor
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = Colors.gray_100
        textView.backgroundColor = Colors.gray_400
        textView.isHidden = true
        textView.textContainerInset = UIEdgeInsets(
            top: Spacings.md,
            left: Spacings.md,
            bottom: Spacings.md,
            right: Spacings.md
        )
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = Colors.primaryLight
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let errorStateView: ErrorStateView = {
        let view = ErrorStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        viewModel.fetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBackButton(color: Colors.primaryLight)
        setupNavigation()
    }

    // MARK: - Methods

    private func setupViewStyle() {
        view.backgroundColor = Colors.background
        title = Strings.navigationTitle

        setupViewHierarchy()
        setupViewConstraints()
        setupData()
    }

    private func setupViewHierarchy() {
        view.addSubview(avatar)
        view.addSubview(titleLabel)
        view.addSubview(contentTextView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorStateView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacings.sm),
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: Spacings.md),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.sm),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.sm),

            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacings.md),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.sm),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.sm),
            contentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.xs),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            errorStateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacings.xl),
            errorStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Spacings.lg),
            errorStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -Spacings.lg)
        ])
    }

    private func setupNavigation() {
        let buttonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(didTapFavoriteButton)
        )
        buttonItem.tintColor = Colors.primaryLight

        navigationItem.rightBarButtonItem = buttonItem

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.background
        appearance.titleTextAttributes = [.foregroundColor: Colors.primaryLight]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: Colors.primaryLight,
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupData() {
        titleLabel.text = viewModel.getUserName()
        if let url = viewModel.getAvatar(), let imageURL = URL(string: url) {
            avatar.download(from: imageURL)
        }
    }

    private func setupBindings() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            self.loadingIndicator.isHidden = !isLoading
            isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
        }

        viewModel.error.bind { [weak self] errorMessage in
            guard let self = self else { return }

            if let errorMessage = errorMessage {
                self.showErrorState(with: errorMessage)
            }
        }

        viewModel.content.bind { [weak self] content in
            self?.contentTextView.text = content
            self?.contentTextView.isHidden = false
        }
    }

    private func showErrorState(with message: String) {
        errorStateView.isHidden = false
        contentTextView.isHidden = true
        errorStateView.setup(
            message: message,
            buttonText: Strings.tryAgainButtonTitle
        ) { [weak self] in
            self?.errorStateView.isHidden = true
            self?.viewModel.fetch()
        }
    }

    // MARK: - Actions

    @objc private func copyContent() {
        viewModel.copyContent(text: contentTextView.text)
    }

    @objc private func didTapFavoriteButton() {
        viewModel.favoriteItem()
    }
}
