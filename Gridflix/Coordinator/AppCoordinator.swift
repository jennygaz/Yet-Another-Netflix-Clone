//
//  AppCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 19/09/24.
//
import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .app
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var dependencyRepository: any DependencyContainer
    weak var finishDelegate: (any CoordinatorFinishDelegate)?

    // MARK: - Lifetime
    init(
        navigationController: UINavigationController,
        finishDelegate: (any CoordinatorFinishDelegate)? = nil,
        dependencyRepository: any DependencyContainer
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
        self.dependencyRepository = dependencyRepository
    }

    // MARK: - Public Methods
    func start() {
        // TODO: - Refactor coordinator creation to a factory
        startLaunchFlow()
//        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
//        profileCoordinator.finishDelegate = self
//        childCoordinators.append(profileCoordinator)
//        profileCoordinator.start()
    }

    // MARK: - Private Methods
    private func configureNavBar() {
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    private func startLaunchFlow() {
        let launchCoordinator = LaunchCoordinator(navigationController: navigationController, finishDelegate: self)
        childCoordinators.append(launchCoordinator)
        launchCoordinator.start()
    }

    private func startMainFlow() {
        startSessionFlow() // TODO: - Remove
        guard dependencyRepository.sessionRepository.hasActiveSession else {
            startSessionFlow()
            return
        }
        let profileSelectionCoordinator = ProfileCoordinator(
            navigationController: navigationController,
            finishDelegate: self)
        childCoordinators.append(profileSelectionCoordinator)
        profileSelectionCoordinator.start()
    }

    private func startTabFlow() {
        // TODO: - Start the main app flow
    }

    private func startSessionFlow() {
        // TODO: - Make session coordinator then make it do either sign in, onboarding, finish on acquiring and confirming a session
        let sessionCoordinator = SessionCoordinator(
            navigationController: navigationController,
            finishDelegate: self)
        childCoordinators.append(sessionCoordinator)
        sessionCoordinator.start()
    }
}

// AppCoordinator handles Session, Launch, ProfileSelection, Tab
// TODO: - In Progress, finish making the coordinators even if they don't do anything yet!
extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        switch child.coordinatorType {
        case .launch: // On Launch finishing
            navigationController.viewControllers.removeAll()
            if dependencyRepository.sessionRepository.hasActiveSession {
                startMainFlow()
            } else {
                startSessionFlow()
            }
        case .tab:
            startSessionFlow()
        case .profile:
            startTabFlow()
        case .session:
            startMainFlow()
        case .onboarding, .player, .app: // App doesn't handle these cases
            break
        }
    }
}
