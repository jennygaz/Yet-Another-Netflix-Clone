//
//  CarouselItemView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 26/09/24.
//

import UIKit

final class CarouselItemView: UIView {
    // MARK: - Properties
    private let imageName: String
    private let text: String

    lazy var imageView: UIImageView = {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 3
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.text = text
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var gradientMask: UIView = {
        let view = UIView(frame: frame)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()

    // MARK: - Lifetime
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }

    init(frame: CGRect = .zero, imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
        super.init(frame: frame)
        configureLayout()
    }

    // MARK: - Private Properties
    private func configureLayout() {
        addSubview(imageView)
        imageView.addSubview(gradientMask)
        addSubview(descriptionLabel)

        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
    }
}
