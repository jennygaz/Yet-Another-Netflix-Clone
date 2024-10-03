//
//  LaunchCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//

import UIKit

final class LaunchCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .launch
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

    func start() {
        let vc = LaunchViewController()
        let presenter = LaunchPresenter(view: vc, delegate: self)
        vc.presenter = presenter
        navigationController.pushViewController(vc, animated: true)
        presenter.startLaunch()
    }
}

extension LaunchCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        // No more cleanup needed for now
        
    }
}
