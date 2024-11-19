//
//  Coordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 19/09/24.
//
import UIKit

@MainActor
protocol Coordinator: AnyObject {
    var coordinatorType: CoordinatorType { get }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [any Coordinator] { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(child: self)
    }
}
