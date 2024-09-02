import UIKit

public final class InformationStateView: UIView {
    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Colors.gray_100
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Colors.gray_200
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.primary
        button.setTitleColor(Colors.gray_100, for: .normal)
        button.layer.cornerRadius = Border.CornerRadius.md
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializer

    public init() {
        super.init(frame: .zero)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    public func setup(
        title: String,
        subtitle: String,
        buttonText: String,
        action: @escaping () -> Void
    ) {
        titleLabel.text = title
        descriptionLabel.text = subtitle
        actionButton.setTitle(buttonText, for: .normal)

        actionButton.addAction(
            UIAction(handler: { _ in action() }),
            for: .touchUpInside
        )
    }

    private func setupViewStyle() {
        backgroundColor = Colors.gray_400
        layer.cornerRadius = Border.CornerRadius.md

        setupHierarchy()
        setupConstraints()
    }

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(actionButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, 
                                            constant: Spacings.lg),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Spacings.md),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Spacings.md),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                  constant: Spacings.md),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: Spacings.md),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Spacings.md),

            actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                              constant: Spacings.lg),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: Spacings.lg),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                       constant: -Spacings.lg),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                 constant: -Spacings.lg),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
