//
//  OnboardingCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//
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
        // TODO: - Add Onboarding Presenter instantiation
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
