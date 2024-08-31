import UIKit

public final class DefaultItemView: UIView {
    // MARK: - Views

    private let avatar = Avatar()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = Colors.gray_100
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Colors.gray_200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    public func setupData(title: String?, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }

    private func setupViewStyle() {
        backgroundColor = Colors.gray_400
        layer.cornerRadius = 8

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(avatar)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    private func setupViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: Spacings.sm),
            avatar.centerYAnchor.constraint(equalTo: centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Spacings.sm),
            titleLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor,
                                                constant: Spacings.sm),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Spacings.sm),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: Spacings.xs),
            subtitleLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor,
                                                   constant: Spacings.sm),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -Spacings.sm),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                  constant: -Spacings.sm),
        ])
    }
}
