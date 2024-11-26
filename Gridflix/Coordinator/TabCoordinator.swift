//
//  TabCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//

import UIKit

@MainActor
final class TabCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .tab
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: (any CoordinatorFinishDelegate)?

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
        
    }

    // MARK: - Private Methods
    private func configureNavBar() {
        self.navigationController.setNavigationBarHidden(false, animated: true)
    }
}

extension TabCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        switch child.coordinatorType {
        case .player:
            print("Handle DataPlayer case")
        default:
            break
        }
    }
}
