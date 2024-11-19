//
//  WelcomeView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 25/09/24.
//

import UIKit

struct WelcomeModel {
    var welcomeText: String
    var imageName: String
    var registerText: String
    var privacyText: String
    var signInText: String
}

final class WelcomeUIView: UIView {
    // MARK: - Properties
    // TODO: - Refactor into bindings
    private var text: String
    private var imageName: String
    weak var welcomeDelegate: WelcomeDelegate?

    // MARK: - Lifetime
    init(
        frame: CGRect = .zero,
        text: String = "Unlimited movies, TV shows & more",
        imageName: String = "WelcomeImage",
        delegate: WelcomeDelegate? = nil
    ) {
        self.text = text
        self.imageName = imageName
        self.welcomeDelegate = delegate
        super.init(frame: frame)
        configureLayout()
    }

    @available(*, deprecated, message: "Deprecated in favour of dependency injection")
    required init?(coder: NSCoder) {
        fatalError("required init?(coder:) was deprecated in favour of dependency injection")
    }

    // MARK: - Lazy Properties
    lazy var topBarContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.alignment = .center
        container.backgroundColor = .black
        container.translatesAutoresizingMaskIntoConstraints = false
        container.spacing = 5
        return container
    }()

    lazy var logoView: UIImageView = {
        let image = UIImage(named: "netflix_n_logo")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var fillerView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var privacyButton: UIButton = {
        let button = UIButton()
        let config = UIButton.Configuration.borderless()
        button.configuration = config
        button.configurationUpdateHandler = makeButtonHandler(
            text: "Privacy",
            style: .headline,
            button: button)
        button.tintColor = .white.withAlphaComponent(0.7)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var signInButton: UIButton = {
        let button = UIButton()
        let config = UIButton.Configuration.borderless()
        button.configuration = config
        button.configurationUpdateHandler = makeButtonHandler(
            text: "Sign In",
            style: .headline,
            button: button)
        button.tintColor = .white.withAlphaComponent(0.7)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var imageView: GradientImageView = {
        let image = UIImage(named: imageName)
        let topColor = CGColor(red: 47.0 / 255.0, green: 76.0 / 255.0, blue: 233.0 / 255.0, alpha: 0.0) // 2E4CE9, 0%
        let bottomColor = CGColor(red: 0.0, green: 4.0 / 255.0, blue: 105.0 / 255.0, alpha: 1.0) // 000469, 100%
        let imageView = GradientImageView(
            image: image,
            stops: [
                .init(color: topColor, point: 0.7),
                .init(color: bottomColor, point: 1.0)
            ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var welcomeText: UILabel = {
        let textView = UILabel()
        let fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        textView.font = font
        textView.textColor = .white
        textView.text = text
        textView.numberOfLines = 3
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var registerContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var registerButton: UIButton = {
        let button = UIButton(frame: self.frame)
        let fontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
        var config = UIButton.Configuration.borderedProminent()
        config.buttonSize = .large
        config.title = "Get Started"
        config.cornerStyle = .large
        button.configuration = config
        button.configurationUpdateHandler = makeButtonHandler(
            text: "Get Started",
            style: .title1,
            weight: .medium,
            button: button)
        button.tintColor = .systemRed
        return button
    }()
}

extension WelcomeUIView {
    // MARK: - Private Methods
    private func makeButtonHandler(text: String, style: UIFont.TextStyle, weight: UIFont.Weight? = nil, button: UIButton) -> UIButton.ConfigurationUpdateHandler {
        let appliedFont: UIFont
        if let weight {
            let fontSize = UIFont.preferredFont(forTextStyle: style).pointSize
            appliedFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        } else {
            appliedFont = UIFont.preferredFont(forTextStyle: style)
        }
        return { button in
            switch button.state {
                default:
                    let attributedTitle = AttributedString(text, attributes: .init([
                        .font: appliedFont
                    ]))
                    button.configuration?.attributedTitle = attributedTitle
                }
        }
    }

    private func configureLayout() {
        backgroundColor = .clear
        var viewConstraints: [NSLayoutConstraint] = []
        // Top Bar Container
        addSubview(topBarContainer)
        viewConstraints.append(contentsOf: [
            topBarContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topBarContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBarContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBarContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
        ])

        // Logo View
        topBarContainer.addArrangedSubview(logoView)
        viewConstraints.append(contentsOf: [
            logoView.leadingAnchor.constraint(equalTo: topBarContainer.leadingAnchor, constant: 5),
            logoView.heightAnchor.constraint(equalTo: topBarContainer.heightAnchor, multiplier: 0.9),
            logoView.widthAnchor.constraint(equalTo: topBarContainer.heightAnchor, multiplier: 0.9)
        ])

        // Privacy & Sign In
        privacyButton.addTarget(self, action: #selector(privacyBridge), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInBridge), for: .touchUpInside)
        topBarContainer.addArrangedSubview(fillerView)
        topBarContainer.addArrangedSubview(privacyButton)
        topBarContainer.addArrangedSubview(signInButton)
        viewConstraints.append(contentsOf: [
            privacyButton.trailingAnchor.constraint(equalTo: signInButton.leadingAnchor, constant: -5),

            signInButton.trailingAnchor.constraint(equalTo: topBarContainer.leadingAnchor, constant: -20)
        ])

        // Image View & Mask
        addSubview(imageView)
        viewConstraints.append(contentsOf: [
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        // Register
        registerButton.addTarget(self, action: #selector(registerBridge), for: .touchUpInside)
        addSubview(registerContainer)
        registerContainer.addArrangedSubview(registerButton)
        viewConstraints.append(contentsOf: [
            registerContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            registerContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.075)
        ])

        // Welcome Text
        addSubview(welcomeText)
        viewConstraints.append(contentsOf: [
            welcomeText.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeText.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -20),
            welcomeText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.55),
        ])
        NSLayoutConstraint.activate(viewConstraints)

        bringSubviewToFront(topBarContainer)
        bringSubviewToFront(welcomeText)
        bringSubviewToFront(registerButton)
        bringSubviewToFront(privacyButton)
        bringSubviewToFront(signInButton)
    }
}

// MARK: - Objective-C Bridging functions
extension WelcomeUIView {
    @objc
    private func signInBridge() {
        welcomeDelegate?.signIn()
    }

    @objc
    private func privacyBridge() {
        welcomeDelegate?.privacy()
    }

    @objc
    private func registerBridge() {
        welcomeDelegate?.register()
    }
}

@available(iOS 17, *)
#Preview("Welcome View") {
    let vc = WelcomeViewController()
    return vc
}
