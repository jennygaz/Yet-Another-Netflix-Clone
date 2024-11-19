//
//  CarouselItemView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 26/09/24.
//

import UIKit

struct CarouselModel {
    let imageName: String
    let text: String
}

final class CarouselItemView: UICollectionViewCell {
    static let identifier: String = "CarouselItemView"
    // MARK: - Properties
    private var model: CarouselModel = .init(imageName: "naruto_hero_view", text: "Naruto Shippuden")

    lazy var imageView: UIImageView = {
        let image = UIImage(named: model.imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 3
        textView.font = .preferredFont(forTextStyle: .title2)
        textView.text = model.text
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
        view.clipsToBounds = true
        view.layer.insertSublayer(gradientLayer, at: 0)
        return view
    }()

    // MARK: - Lifetime
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.model = CarouselModel(imageName: "naruto_hero_view", text: "Naruto Shippuden")
        configureLayout()
    }

    // MARK: - Public Methods
    public func configure(with model: CarouselModel) {
        let image = UIImage(named: model.imageName)
        imageView.image = image
        descriptionLabel.text = model.text
    }

    // MARK: - Private Methods
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

@available(iOS 17, *)
#Preview {
    let vc = UIViewController()
    let cell = CarouselItemView(frame: vc.view?.frame ?? .zero)
    vc.view = cell
    cell.configure(with: CarouselModel(imageName: "naruto_hero_view", text: "Naruto Shippuden"))
    return vc
}
