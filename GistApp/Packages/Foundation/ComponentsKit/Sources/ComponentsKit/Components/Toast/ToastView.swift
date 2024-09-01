import UIKit

public class ToastView: UIView {
    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Colors.gray_100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle")
        imageView.tintColor = Colors.gray_100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = Colors.gray_100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private let displayDuration = 0.6

    // MARK: - Initializer
    
    public init(text: String) {
        super.init(frame: .zero)

        setupViewStyle()
        setupData(text: text)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if closeButton.frame.contains(point) {
            return closeButton
        }
        return super.hitTest(point, with: event)
    }

    // MARK: - Methods

    public func show(in view: UIView, duration: TimeInterval = 2.0) {
        setupOnSuperview(view)
        setupAnimation(duration: duration)
    }

    private func setupViewStyle() {
        backgroundColor = Colors.primaryDark
        layer.cornerRadius = Border.CornerRadius.md
        layer.masksToBounds = true

        closeButton.addTarget(self, action: #selector(dismissToast), for: .touchUpInside)

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(closeButton)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacings.sm),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Spacings.lg),
            iconImageView.heightAnchor.constraint(equalToConstant: Spacings.lg),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Spacings.xs),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            closeButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Spacings.xs),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacings.sm),
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: Spacings.lg),
            closeButton.heightAnchor.constraint(equalToConstant: Spacings.lg),
        ])
    }

    private func setupData(text: String) {
        titleLabel.text = text
    }

    private func setupOnSuperview(_ view: UIView) {
        view.addSubview(self)

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacings.md),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacings.md),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Spacings.md),
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupAnimation(duration: TimeInterval) {
        alpha = 0

        UIView.animate(withDuration: displayDuration) { [weak self] in
            self?.alpha = 1
        } completion: { [weak self] _ in
            guard let self else { return }
            UIView.animate(withDuration: self.displayDuration, delay: duration, options: .curveEaseOut) {
                self.alpha = 0
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }

    // MARK: - Actions

    @objc private func dismissToast() {
        removeFromSuperview()
    }
}
