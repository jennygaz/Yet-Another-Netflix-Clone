import UIKit
import SwiftUI

final class WelcomeViewController: UIViewController {
    var presenter: WelcomeViewPresenter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        presenter?.loadWelcomeData()
    }

    override func loadView() {
        super.loadView()
        let welcomeView = HomeHeaderView(frame: view.frame)
//        WelcomeUIView(
//            frame: view.frame,
//            text: "Unlimited movies, TV shows & more",
//            imageName: "WelcomeImage",
//            delegate: self)
        self.view = welcomeView
//        addChild(hostingController)
//        view = hostingController.view
    }

    // MARK: - Private Methods
    private func configureNavBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension WelcomeViewController: WelcomeDelegate {
    func signIn() {
        print("Sign in called")
    }

    func privacy() {
        print("Privacy called")
    }

    func register() {
        print("Register called")
    }
}

@available(iOS 17, *)
#Preview("Welcome VC") {
    let vc = WelcomeViewController(nibName: nil, bundle: nil)
    return vc
}
