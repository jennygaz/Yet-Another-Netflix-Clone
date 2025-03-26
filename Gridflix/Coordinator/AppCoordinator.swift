import UIKit
import SwiftUI

/// Handle the interactions between starting a new ``Coordinator`` and finishing another
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
        let mainTabBarController = MainTabBarController(container: dependencyRepository)
        navigationController.pushViewController(mainTabBarController, animated: true)
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
        default: // AppCoordinator doesn't handle other cases
            break
        }
    }
}
