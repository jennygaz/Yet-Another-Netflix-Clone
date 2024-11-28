//
//  CarouselItemView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 26/09/24.
//

import UIKit

final class DefaultTitleCell: UICollectionViewCell {
    static let identifier: String = "DefaultTitleCell"
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 3
        textView.font = .preferredFont(forTextStyle: .title2)
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
        configureLayout()
    }

    // MARK: - Public Methods
    public func configure(with model: Title) {
        let image = UIImage(named: model.posterURL)
        imageView.image = image
        descriptionLabel.text = model.description
    }

    // MARK: - Private Methods
    private func configureLayout() {
        addSubview(imageView)
//        imageView.addSubview(gradientMask)
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

#if DEBUG

struct MockCarouselTitle {
    var name: String { "Naruto Shippuden" }
    var imageName: String { "naruto_hero_view" }
    var text: String { "Naruto Shippuden" }
}

@available(iOS 17, *)
#Preview {
    let vc = UIViewController()
    let cell = DefaultTitleCell(frame: vc.view?.frame ?? .zero)
    vc.view = cell
    let model = Title(id: 1, mediaType: "TV Series", name: "Naruto Shippuden", title: "Naruto Shippuden", posterURL: "naruto_hero_view", description: "", voteCount: 1, voteAverage: 1.0, releaseDate: .now)
    cell.configure(with: model)
    return vc
}
#endif
