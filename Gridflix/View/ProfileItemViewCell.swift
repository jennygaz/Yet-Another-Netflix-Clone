//
//  ProfileItemViewCell.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 17/09/24.
//

import UIKit

final class ProfileItemViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ProfileItemViewCell"
    // MARK: - Properties
    public var currentName: String = ""
    public var buttonColor: UIColor = .systemRed
    public var type: ProfileType = .custom {
        didSet { if type == .default { makeDefault() } }
    }
    private let nameLabel: UILabel
    private let profileButton: UIButton

    // MARK: - Lifetime
    override init(frame: CGRect) {
        self.nameLabel = UILabel()
        self.profileButton = UIButton()
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    public func configure(with name: String, color: UIColor = .systemRed) {
        nameLabel.text = name
        nameLabel.textColor = .white
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.sizeToFit()
        let image = UIImage(systemName: "square.fill")?
            .applyingSymbolConfiguration(.init(pointSize: 100))?
            .withRenderingMode(.alwaysTemplate)

        profileButton.setImage(image, for: .normal)
        profileButton.setImage(image, for: .disabled)
        profileButton.setImage(image, for: .focused)
        profileButton.setImage(image, for: .selected)
        profileButton.tintColor = color
    }

    public func makeDefault() {
        let addImage = UIImage(systemName: "plus.app")?
            .applyingSymbolConfiguration(.init(pointSize: 100))?
            .withRenderingMode(.alwaysTemplate)
            .withTintColor(.darkGray)
        profileButton.setImage(addImage, for: .normal)
        profileButton.setImage(addImage, for: .disabled)
        profileButton.setImage(addImage, for: .focused)
        profileButton.setImage(addImage, for: .selected)
        profileButton.tintColor = .darkGray

        nameLabel.text = "Add Profile"
        nameLabel.textColor = .white
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.sizeToFit()
    }

    private func setupElements() {
        addSubview(profileButton)
        addSubview(nameLabel)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        let constraints: [NSLayoutConstraint] = [
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileButton.topAnchor.constraint(equalTo: topAnchor),
            profileButton.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 5),

            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        configure(with: self.currentName, color: self.buttonColor)
    }
}

@available(iOS 17, *)
#Preview("Profile Item View Cell") {
    let view = ProfileItemViewCell(
        frame: CGRect(x: 100, y: 100, width: 200, height: 200))
    return view
}
