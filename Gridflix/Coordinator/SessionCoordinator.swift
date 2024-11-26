//
//  SessionCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//
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
        let welcomeVC = WelcomeViewController()
        welcomeVC.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController.viewControllers.removeAll()
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(welcomeVC, animated: true)
    }

    // MARK: - Private Methods
    private func startSignInFlow() {
        
    }

    private func startOnboardingFlow() {
        
    }
}

extension SessionCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        switch child.coordinatorType {
        // TODO: - Handle Sign In case
        case .sign:
            break
        default:
            break
        }
    }
}
