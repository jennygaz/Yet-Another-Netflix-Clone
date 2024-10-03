//
//  LaunchViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//

import UIKit
import Lottie

final class LaunchViewController: UIViewController {
    // MARK: - Properties
    var presenter: LaunchViewPresenter?
    private var animationView: LottieAnimationView?
    private let animationName = "NetflixSplash"

    // MARK: - Lifetime
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private methods
    private func configureLottieView() {
        guard let path = Bundle.main.path(forResource: animationName, ofType: "json") else {
            fatalError("Unable to find Lottie file \(animationName).json")
        }
        animationView = .init(frame: view.frame)
        view.addSubview(animationView!)
        animationView!.animation = LottieAnimation.filepath(path)
        animationView!.frame = view.frame
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .playOnce
        animationView!.animationSpeed = 0.8
        animationView!.play(
            fromProgress: 0,
            toProgress: 0.8,
            loopMode: .playOnce) { [weak self] _ in
                self?.presenter?.finish()
            }
    }
}

extension LaunchViewController: LaunchView {
    func start() {
        configureLottieView()
    }
}

@available(iOS 17, *)
#Preview("Lottie Splash Screen") {
    let vc = LaunchViewController()
    return vc
}
