import UIKit

@MainActor
final class OnboardingCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .onboarding
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var finishDelegate: (any CoordinatorFinishDelegate)?

    // MARK: - Lifetime
    init(
        navigationController: UINavigationController,
        finishDelegate: (any CoordinatorFinishDelegate)? = nil
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }

    // MARK: - Public Methods
    func start() {
        let onboardingVC = OnboardingViewController()
        let presenter = OnboardingPresenter(view: onboardingVC, delegate: self)
        onboardingVC.presenter = presenter
        navigationController.pushViewController(onboardingVC, animated: true)
        presenter.startOnboarding()
    }

    // MARK: - Private Methods
    private func configureNavBar() {
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
}

extension OnboardingCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
    }
}
