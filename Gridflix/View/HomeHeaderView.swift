//
//  HeroHeaderUIView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/10/24.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
    // MARK: - Identifier
    static let identifier = "HomeHeaderView"

    // MARK: - Properties
    var model: HighlightMovie = .default {
        didSet {
            guard oldValue.categories != model.categories else {
                return
            }
            configure(with: model)
        }
    }

    var state: HomeFilter? {
        didSet { updateFilters() }
    }

    private lazy var topContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .leading
        container.spacing = 4.0
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var topContainerMutableConstraint: NSLayoutConstraint = {
        topContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -(frame.width / 4))
    }()

    // Have independent State
    private lazy var moviesFilterButton: OutlineButton = {
        var config = UIButton.Configuration.outline()
        config.title = "Movies"
        let button = OutlineButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        button.shouldHighlight = true
        return button
    }()

    // Have independent State
    private lazy var tvShowsFilterButton: OutlineButton = {
        var config = UIButton.Configuration.outline()
        config.title = "TV Shows"
        let button = OutlineButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        button.shouldHighlight = true
        return button
    }()

    // Have independent State
    private lazy var categoriesFilterButton: OutlineButton = {
        var config = UIButton.Configuration.outline()
        config.title = "Categories"
        config.image = UIImage(systemName: "chevron.down")
        config.imagePlacement = .trailing
        let button = OutlineButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .regular)
        button.tintColor = .white
        button.shouldHighlight = true
        return button
    }()

    private lazy var xButtonTopContainer: UIButton = {
        var config = UIButton.Configuration.outline()
        config.image = UIImage(named: "custom.x")
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let button = OutlineButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.titleLabel?.font = .systemFont(ofSize: 2.0, weight: .heavy)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()

    private lazy var heroImageView: UIImageView = {
        let imageView = GradientImageView(
            image: UIImage(named: "naruto_hero_view"), // State
            stops: [
                .init(color: UIColor.clear.cgColor, point: 0.0),
                .init(color: UIColor.white.withAlphaComponent(0.4).cgColor, point: 0.7),
                .init(color: UIColor.black.withAlphaComponent(0.4).cgColor, point: 1.0)
            ])
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 24.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var heroLogoView: UIImageView = {
        let image = UIImage(named: "naruto_logo") // State
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var displayedCategories: UIStackView = {
        let container = UIStackView(arrangedSubviews: [])
        container.axis = .horizontal
        container.spacing = 6.0
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var bottomButtonsContainer: UIStackView = {
        let container = UIStackView(arrangedSubviews: [])
        container.axis = .horizontal
        container.spacing = 12.0
        container.distribution = .fillEqually
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var playButton: UIButton = {
        var config = UIButton.Configuration.borderedProminent()
        let icon = UIImage(systemName: "play.fill")
        config.title = "Play"
        config.image = icon
        config.imagePlacement = .leading
        config.imagePadding = 4.0
        let button = UIButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.tintColor = .white
        button.titleLabel?.textColor = .black
        return button
    }()

    private lazy var myListButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        let icon = UIImage(systemName: model.isListed ? "checkmark" : "plus") // TODO: Add State here for using the proper icon
        config.title = "My List"
        config.image = icon
        config.imagePlacement = .leading
        config.imagePadding = 4.0
        let button = UIButton(configuration: config)
        if #available(iOS 17, *) {
            button.isSymbolAnimationEnabled = true
        }
        button.tintColor = .white
        return button
    }()

    private lazy var backgroundBlur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        blurView.contentView.addSubview(vibrancyView)
        NSLayoutConstraint.activate([
            vibrancyView.topAnchor.constraint(equalTo: blurView.topAnchor),
            vibrancyView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor),
            vibrancyView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            vibrancyView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor)
        ])
        return blurView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(backgroundBlur)
        addSubview(topContainer)
        addSubview(heroImageView)
        addSubview(heroLogoView)
        addSubview(displayedCategories)
        addSubview(bottomButtonsContainer)
        bottomButtonsContainer.addArrangedSubview(playButton)
        bottomButtonsContainer.addArrangedSubview(myListButton)
        bringSubviewToFront(topContainer)
        
        applyConstraints()
        configureBannerCategories(with: model.categories)
        addActions()
    }

    public func configure(with model: HighlightMovie) {
        guard let mainImage = UIImage(named: model.mainImage),
              let logo = UIImage(named: model.logo)
        else { return }
        // TODO: - Set image asynchronously
        heroImageView.image = mainImage
        heroLogoView.image = logo
        let listIcon = UIImage(systemName: model.isListed ? "checkmark" : "plus")
        myListButton.configuration?.image = listIcon
        backgroundColor = model.backgroundColor
        configureBannerCategories(with: model.categories)
    }

    public func configureBannerCategories(with categories: [String]) {
        guard !categories.isEmpty else { return }
        let subviews = displayedCategories.subviews
        subviews.forEach {
            displayedCategories.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        let separators = Array(repeating: "custom.dot", count: categories.count - 1).map { separator in
            CategoryHeroLabel(assetName: separator)
        }
        let sublabels = categories.map { category in
            CategoryHeroLabel(text: category)
        }
        var result = zip(sublabels.dropLast(), separators).map {
            [$0, $1]
        }
            .flatMap { $0 }
        result.append(sublabels.last!)
        result.forEach {
            displayedCategories.addArrangedSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Layout
extension HomeHeaderView {
    private func updateFilters() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: [state == nil ? .curveEaseOut : .curveEaseIn]) { [unowned self] in
                switch self.state {
                case .tvShows:
                    moviesFilterButton.isHidden = true
                    categoriesFilterButton.isHidden = true
                    xButtonTopContainer.isHidden = false
                    categoriesFilterButton.configuration?.title = "Categories"
                    tvShowsFilterButton.shouldHighlight = false
                case .movies:
                    tvShowsFilterButton.isHidden = true
                    categoriesFilterButton.isHidden = true
                    xButtonTopContainer.isHidden = false
                    categoriesFilterButton.configuration?.title = "Categories"
                    moviesFilterButton.shouldHighlight = false
                case .categories(let category):
                    guard category != .home else { return }
                    moviesFilterButton.isHidden = true
                    tvShowsFilterButton.isHidden = true
                    xButtonTopContainer.isHidden = false
                    categoriesFilterButton.configuration?.title = category.description
                    categoriesFilterButton.shouldHighlight = false
                case nil:
                    tvShowsFilterButton.isHidden = false
                    moviesFilterButton.isHidden = false
                    categoriesFilterButton.isHidden = false
                    xButtonTopContainer.isHidden = true
                    categoriesFilterButton.configuration?.title = "Categories"
                    self.categoriesFilterButton.sizeToFit()
                }
            } completion: { _ in
                
            }
    }

    private func addActions() {
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        myListButton.addTarget(self, action: #selector(myListAction), for: .touchUpInside)
        tvShowsFilterButton.addTarget(self, action: #selector(didSelectTVShows), for: .touchUpInside)
        moviesFilterButton.addTarget(self, action: #selector(didSelectMovies), for: .touchUpInside)
        categoriesFilterButton.addTarget(self, action: #selector(didSelectCategories), for: .touchUpInside)
        xButtonTopContainer.addTarget(self, action: #selector(didSelectXButton), for: .touchUpInside)
        heroImageView.isUserInteractionEnabled = true
        heroLogoView.isUserInteractionEnabled = true
        let touchUpInsideGestureRecognizerImage = UITapGestureRecognizer(target: self, action: #selector(didSelectImage))
        let touchUpInsideGestureRecognizerLogo = UITapGestureRecognizer(target: self, action: #selector(didSelectImage))
        let touchUpInsideGestureRecognizerCategories = UITapGestureRecognizer(target: self, action: #selector(didSelectImage))
        heroImageView.addGestureRecognizer(touchUpInsideGestureRecognizerImage)
        heroLogoView.addGestureRecognizer(touchUpInsideGestureRecognizerLogo)
        displayedCategories.addGestureRecognizer(touchUpInsideGestureRecognizerCategories)
    }
    
    private func applyConstraints() {
        var viewConstraints: [NSLayoutConstraint] = []
        topContainer.addArrangedSubview(xButtonTopContainer)
        topContainer.addArrangedSubview(tvShowsFilterButton)
        topContainer.addArrangedSubview(moviesFilterButton)
        topContainer.addArrangedSubview(categoriesFilterButton)

        viewConstraints.append(contentsOf: [
            backgroundBlur.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundBlur.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backgroundBlur.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundBlur.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])

        viewConstraints.append(contentsOf: [
            topContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        viewConstraints.append(contentsOf: [
            heroImageView.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 20),
            heroImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            heroImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])

        viewConstraints.append(contentsOf: [
            heroLogoView.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 25),
            heroLogoView.widthAnchor.constraint(equalTo: heroImageView.widthAnchor, multiplier: 0.6),
            heroLogoView.centerXAnchor.constraint(equalTo: heroImageView.centerXAnchor)
        ])

        viewConstraints.append(contentsOf: [
            displayedCategories.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 10),
            displayedCategories.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: -10),
            displayedCategories.bottomAnchor.constraint(equalTo: bottomButtonsContainer.topAnchor, constant: -25)
        ])

        viewConstraints.append(contentsOf: [
            bottomButtonsContainer.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -20),
            bottomButtonsContainer.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor, constant: 20),
            bottomButtonsContainer.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate(viewConstraints)
    }
}

// MARK: - Objective-C Bridging
extension HomeHeaderView {
    @objc
    private func playAction() {
        print("Now playing \(model.name)")
    }

    @objc
    private func myListAction() {
        UIView.animate(withDuration: 0.2) { [unowned self] in
            model.isListed.toggle()
            let icon = UIImage(systemName: model.isListed ? "checkmark" : "plus")
            myListButton.setImage(icon, for: .normal)
        }
    }

    @objc
    private func didSelectTVShows() {
        guard state == nil else { return }
        self.state = .tvShows
    }

    @objc
    private func didSelectMovies() {
        guard state == nil else { return }
        self.state = .movies
    }

    @objc
    private func didSelectCategories() {
        guard state == nil else { return }
        self.state = .categories(.allCases.randomElement()!)
    }

    @objc
    private func didSelectXButton() {
        guard state != nil else { return }
        categoriesFilterButton.shouldHighlight = true
        categoriesFilterButton.wasHighlighted = false
        tvShowsFilterButton.shouldHighlight = true
        tvShowsFilterButton.wasHighlighted = false
        moviesFilterButton.shouldHighlight = true
        moviesFilterButton.wasHighlighted = false
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.categoriesFilterButton.updateConfiguration()
            self.moviesFilterButton.updateConfiguration()
            self.tvShowsFilterButton.updateConfiguration()
        }
        self.state = nil
    }

    @objc
    private func didSelectImage() {
        print("Movie \(model.name) selected")
    }
}

@available(iOS 17, *)
#Preview("Home Header") {
    let vc = UIViewController()
    let homeView = HomeHeaderView(frame: vc.view.bounds)
    let model = HighlightMovie(
        name: "Naruto Shippuden",
        mainImage: "naruto_hero_view",
        logo: "naruto_logo",
        categories: [
            "Ninja",
            "Slow Pace",
            "Fighting",
            "Edgy",
            "Dark"
        ],
        isListed: true,
        backgroundColor: .black.withAlphaComponent(0.8))
    homeView.model = model
    vc.view = homeView
    return vc
}
