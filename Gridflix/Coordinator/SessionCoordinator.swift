import UIKit
import SwiftUI

@MainActor
final class SessionCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .session
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
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
        if shouldStartSignInFlow() {
            startSignInFlow()
        } else {
            startOnboardingFlow()
        }
    }

    // MARK: - Private Methods
    private func startSignInFlow() {
        let signInVC = SignInViewController()
        navigationController.pushViewController(signInVC, animated: true)
    }

    private func startOnboardingFlow() {
        let onboardingVC = OnboardingViewController()
        let presenter = OnboardingPresenter(view: onboardingVC, delegate: self)
        onboardingVC.presenter = presenter
        navigationController.pushViewController(onboardingVC, animated: true)
        presenter.startOnboarding()
    }

    private func shouldStartSignInFlow() -> Bool {
        // Add logic to determine whether to start sign-in flow or onboarding flow
        return true
    }
}

extension SessionCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        switch child.coordinatorType {
        case .sign:
            break
        default:
            break
        }
    }
}
