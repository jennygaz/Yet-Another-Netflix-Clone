//
//  PreviewCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 28/11/24.
//

#if DEBUG
import Foundation
import UIKit

public class PreviewCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .app
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: (any CoordinatorFinishDelegate)?

    // MARK: - Lifetime
    init(finishDelegate: (any CoordinatorFinishDelegate)? = nil) {
        self.finishDelegate = finishDelegate
        self.navigationController = UINavigationController()
    }

    // TODO: - Add Inits without a VC for testing transition animations and more

    // MARK: - Public Methods
    func start() {
        
    }
}

extension PreviewCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        
    }
}
#endif
