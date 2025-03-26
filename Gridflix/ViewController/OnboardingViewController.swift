import UIKit

final class OnboardingViewController: UIViewController {
    var presenter: OnboardingViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.startOnboarding()
    }
}
