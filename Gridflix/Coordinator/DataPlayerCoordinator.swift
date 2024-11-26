//
//  DataPlayerCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//

import UIKit

@MainActor
final class DataPlayerCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .player
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
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
}

extension DataPlayerCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
    }
}
