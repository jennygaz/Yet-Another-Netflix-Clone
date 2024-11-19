//
//  SessionCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//
import UIKit
import SwiftUI

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

    func start() {
//        let swiftUIView = WelcomeViewUI()
//        let welcomeVC = UIHostingController(rootView: swiftUIView)
//        welcomeVC.navigationController?.setNavigationBarHidden(true, animated: false)
        let homeVC = HomeViewController(with: self)
        var items: [CompactTitle] = []
        items.reserveCapacity(90)
        for i in 1...90 {
            items.append(CompactTitle(id: i, name: "Naruto Shippuden", imageURL: "naruto_hero_view"))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            homeVC.addElements(items)
        }
//        let welcomeVC = WelcomeViewController()
        navigationController.viewControllers.removeAll()
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(homeVC, animated: true)
    }
}

extension SessionCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
        switch child.coordinatorType {
        case .app, .launch, .tab, .profile, .player, .session:
            break
        case .onboarding:
            break
        }
    }
}
