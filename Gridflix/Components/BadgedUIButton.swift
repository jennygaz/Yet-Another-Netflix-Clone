//
//  BadgedBarButtonItem.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/11/24.
//

import Combine
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

final class BadgedUIButton: UIView {
    // MARK: - Properties
    private var imageView: UIImageView
    private var button: UIButton

    // MARK: - Public Properties
    var paletteColors: [UIColor] = [] {
        didSet { updateImageConfiguration() }
    }

    var badgeTint: UIColor? = nil {
        didSet {
            guard let badgeTint else { return }
            if paletteColors.count >= 2 {
                paletteColors[1] = badgeTint
            } else {
                paletteColors.append(badgeTint)
            }
        }
    }

    var badgeValue: Int? = nil {
        didSet {
            guard let badgeValue else {
                imageView.isHidden = true
                return
            }
            setBadgeValue(count: badgeValue)
        }
    }

    var badgeImage: UIImage? = nil {
        didSet {
            guard let badgeImage else { return }
            setBadgeImage(image: badgeImage)
        }
    }

    // MARK: - Lifecycle
    init(configuration: UIButton.Configuration, primaryAction: UIAction? = nil) {
        self.button = UIButton(configuration: configuration, primaryAction: primaryAction)
        self.imageView = UIImageView()
        super.init(frame: self.button.frame)
        button.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        configureSubviews()
        configureConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("Removed in favour of dependency injection")
    }

    // MARK: - Public Methods
    func setBadgeValue(count: Int) {
        guard count > 0 else { return }
        let text = count > 50 ? "50" : "\(count)"
        let configuration = imageView.image?.configuration
        let newImage = UIImage(systemName: text + ".circle.fill", withConfiguration: configuration)
        setBadgeImage(image: newImage)
    }

    func setBadgeImage(image: UIImage?, paletteColors: [UIColor] = []) {
        guard let image else { return }
        let configuration: UIImage.SymbolConfiguration
        if paletteColors.isEmpty {
            configuration = UIImage.SymbolConfiguration.preferringMulticolor()
        } else {
            configuration = UIImage.SymbolConfiguration(paletteColors: paletteColors)
        }
        self.imageView.image = image.applyingSymbolConfiguration(configuration)
        self.imageView.backgroundColor = .clear
        self.imageView.isHidden = false
    }

    func removeBadgeImage() {
        self.imageView.isHidden = true
    }

    // MARK: - Layout
    private func configureSubviews() {
        addSubview(button)
        addSubview(imageView)
        bringSubviewToFront(imageView)
    }

    private func configureConstraints() {
        guard let buttonImageView = button.imageView else { return }
        let badgeConstraints: [NSLayoutConstraint] = [
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.centerXAnchor.constraint(equalTo: buttonImageView.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: buttonImageView.topAnchor)
        ]
        NSLayoutConstraint.activate(badgeConstraints)
    }

    // MARK: - Private Methods
    private func updateImageConfiguration() {
        let configuration = UIImage.SymbolConfiguration(paletteColors: paletteColors)
        let updatedImage = imageView.image?.withConfiguration(configuration)
        imageView.image = updatedImage
    }
}

@available(iOS 17, *)
#Preview("Badged Bar Button Item") {
    let vc = UIViewController()
    var config = UIButton.Configuration.plain()
    let image = UIImage(systemName: "arrow.down.to.line.alt")?.withTintColor(.white, renderingMode: .alwaysTemplate)
    config.image = image

    let badgeConfiguration = UIImage.SymbolConfiguration(paletteColors: [
        .white, .red
    ])
    let badgeImage = UIImage(systemName: "50.circle.fill", withConfiguration: badgeConfiguration)

    let button = BadgedUIButton(configuration: config)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    vc.view.backgroundColor = .gray
    vc.view.addSubview(button)
    NSLayoutConstraint.activate([
        button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
        button.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
    ])

    button.setBadgeImage(image: badgeImage)
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        button.setBadgeValue(count: 5)
        button.paletteColors = [.blue, .green, .magenta]
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        button.badgeTint = .green
    }
    return vc
}
