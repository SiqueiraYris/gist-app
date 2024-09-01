import UIKit
import ComponentsKit

final class GistCell: UITableViewCell {
    // MARK: - Views

    private let itemView = DefaultItemView()

    // MARK: - Properties

    static let reuseIdentifier = "GistCell"

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewStyle()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setupData(data: DefaultItemData?) {
        itemView.setupData(data: data)
    }

    private func setupViewStyle() {
        backgroundColor = .clear
        selectionStyle = .none

        setupViewHierarchy()
        setupViewConstraints()
    }

    private func setupViewHierarchy() {
        contentView.addSubview(itemView)
    }

    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Spacings.xs),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                              constant: Spacings.sm),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                               constant: -Spacings.sm),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Spacings.sm),
        ])
    }
}
