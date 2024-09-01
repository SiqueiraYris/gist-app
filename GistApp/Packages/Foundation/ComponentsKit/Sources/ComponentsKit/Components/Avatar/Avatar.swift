import UIKit

public final class Avatar: UIImageView {
    // MARK: - Initializer

    public init() {
        super.init(frame: .zero)

        setupViewStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    public override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        layer.borderWidth = Border.Width.sm
        layer.borderColor = Colors.primaryLight.cgColor
    }

    // MARK: - Methods

    private func setupViewStyle() {
        setupViewConstraints()
    }

    private func setupViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 40),
            heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
