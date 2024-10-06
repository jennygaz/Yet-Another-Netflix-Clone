//
//  HeroHeaderUIView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/10/24.
//

import UIKit

class HomeHeaderView: UIView {
    private lazy var topContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .leading
        container.spacing = 4.0
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var moviesFilterButton: UIButton = {
        var config = UIButton.Configuration.outline()
        config.title = "Movies"
        let button = OutlineButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        return button
    }()

    private lazy var tvShowsFilterButton: UIButton = {
        var config = UIButton.Configuration.outline()
        config.title = "TV Shows"
        let button = OutlineButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        return button
    }()

    private lazy var categoriesFilterButton: UIButton = {
        var config = UIButton.Configuration.outline()
        config.title = "Categories"
        config.image = UIImage(systemName: "chevron.down")
        config.imagePlacement = .trailing
        let button = OutlineButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        return button
    }()

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
//        addGradient()
        addSubview(topContainer)
//        addSubview(categoriesFilterButton)
//        addSubview(moviesFilterButton)
//        addSubview(tvShowsFilterButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        topContainer.addArrangedSubview(tvShowsFilterButton)
        topContainer.addArrangedSubview(moviesFilterButton)
        topContainer.addArrangedSubview(categoriesFilterButton)

        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -(frame.width / 4)),
            topContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        ])
//        let moviesFilterButtonConstraints = [
//            moviesFilterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
//            moviesFilterButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
////            moviesFilterButton.widthAnchor.constraint(equalToConstant: 120)
//        ]
//        
//        let tvShowsFilterButtonConstraints = [
////            tvShowsFilterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
//            tvShowsFilterButton.bottomAnchor.constraint(equalTo: categoriesFilterButton.bottomAnchor, constant: -50),
//            tvShowsFilterButton.centerXAnchor.constraint(equalTo: categoriesFilterButton.centerXAnchor),
////            tvShowsFilterButton.widthAnchor.constraint(equalToConstant: 120)
//        ]
//
//        let categoriesButtonConstraints = [
//            categoriesFilterButton.bottomAnchor.constraint(equalTo: moviesFilterButton.topAnchor, constant: -20),
//            categoriesFilterButton.centerXAnchor.constraint(equalTo: moviesFilterButton.centerXAnchor)
//        ]
//        
//        NSLayoutConstraint.activate(moviesFilterButtonConstraints)
//        NSLayoutConstraint.activate(tvShowsFilterButtonConstraints)
//        NSLayoutConstraint.activate(categoriesButtonConstraints)
    }
    
    
    // TODO: - Create a model for the header to configure it
    public func configure(with model: String) {
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
//            return
//        }
        // TODO: - Set image asynchronously
//        heroImageView.sd_setImage(with: url, completed: nil)
//        heroImageView.image = UIImage(named: "WelcomeImage")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

@available(iOS 17, *)
#Preview("Home Header") {
    let vc = UIViewController()
    let homeView = HomeHeaderView(frame: vc.view.bounds)
    homeView.configure(with: "WelcomeImage")
    vc.view = homeView
    return vc
}
