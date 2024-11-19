//
//  SectionTitleHeaderView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 21/10/24.
//

import UIKit

final class SectionTitleHeaderView: UICollectionReusableView {
    // MARK: - Identifier
    static let identifier: String = "SectionTitleHeaderView"

    // MARK: - Properties
    private let label: UILabel = UILabel()

    // MARK: - Lifetime
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupConstraints()
        configure(with: "")
    }

    required init?(coder: NSCoder) {
        fatalError("Deprecated in favour of dependency injection")
    }

    // MARK: - Public Methods
    public func configure(with title: String) {
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.text = title
    }

    // MARK: - Private Methods
    private func setupConstraints() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = 10
        let viewConstraints: [NSLayoutConstraint] = [
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: inset),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: inset)
        ]
        NSLayoutConstraint.activate(viewConstraints)
    }
}

@available(iOS 17, *)
#Preview("Section Title") {
    let vc = UIViewController()
    let header = SectionTitleHeaderView(frame: vc.view?.frame ?? .zero)
    header.configure(with: "Tacos al pastor")
    vc.view = header
    return vc
}
