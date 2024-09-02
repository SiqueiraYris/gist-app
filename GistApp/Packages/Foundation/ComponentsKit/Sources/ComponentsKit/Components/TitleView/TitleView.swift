import UIKit

public final class TitleView: UIView {
    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = Colors.gray_100
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

    public func setupData(title: String?) {
        titleLabel.text = title
    }

    private func setupViewStyle() {
        backgroundColor = Colors.gray_400
        layer.cornerRadius = Border.CornerRadius.md

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(titleLabel)
    }

    private func setupViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Spacings.md),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Spacings.sm),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Spacings.sm),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                               constant: -Spacings.md),
        ])
    }
}
