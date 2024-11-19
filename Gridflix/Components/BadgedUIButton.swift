//
//  BadgedBarButtonItem.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/11/24.
//

import UIKit

enum BadgePosition {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

enum BadgeSize {
    case small, medium, large
}

final class BadgedUIButton: UIButton {
    // MARK: - Properties
    private lazy var badgeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = tintColor
        label.isHidden = true
        label.font = .monospacedSystemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = .red
        return label
    }()

    var badgeTint: UIColor? = nil {
        didSet {
            badgeLabel.textColor = tintColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeLabel)
        configureConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("Removed in favour of dependency injection")
    }

    func setBadgeValue(count: Int) {
        guard count > 0 else {
            badgeLabel.isHidden = true
            return
        }
        let text = count > 99 ? "99+" : "\(count)"
        badgeLabel.text = text
    }

    private func configureConstraints() {
        let badgeConstraints: [NSLayoutConstraint] = [
            badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2)
        ]
        NSLayoutConstraint.activate(badgeConstraints)
    }
}

//@available(iOS 17, *)
//#Preview("Badged Bar Button Item") {}
