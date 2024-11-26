//
//  ProfileCoordinator.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 24/09/24.
//

import UIKit

@MainActor
final class ProfileCoordinator: Coordinator {
    // MARK: - Properties
    let coordinatorType: CoordinatorType = .profile
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
        // TODO: - Refactor VC creation to a factory/manager
        let profileSelectionVC = ProfileSelectionViewController(with: self)
        navigationController.pushViewController(profileSelectionVC, animated: true)
        let items: [ProfileItem] = [
            .init(name: "Jenny", color: .systemPink),
            .init(name: "Isita", color: .systemRed),
            .init(name: "David", color: .systemBlue),
            .init(name: "TV", color: .systemGreen)
        ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            profileSelectionVC.profiles = items
        }
//        configureNavBar()
    }

    // MARK: - Private Methods
    private func configureNavBar() {
        self.navigationController.navigationBar.backgroundColor = .red
//        navigationController.navigationBar.tintColor = .white
        // TODO: - Refactor asset management
        // Netflix Logo
        let netflixLogoImage = UIImage(named: "netflix_logo")
        let netflixLogoView = UIImageView(image: netflixLogoImage)
        netflixLogoView.contentMode = .scaleAspectFit
        
        navigationController.navigationItem.titleView = netflixLogoView
        // Profile Edit Button
        let editIcon = UIImage(systemName: "highlighter")
        let editProfilesButton = UIBarButtonItem(
            image: editIcon,
            style: .plain,
            target: nil,
            action: nil)
        editProfilesButton.tintColor = .white
        navigationController.navigationItem.setRightBarButton(editProfilesButton, animated: true)
//        navigationController.navigationItem.rightBarButtonItem = editProfilesButton
        navigationController.setNavigationBarHidden(false, animated: true)
    }
}

extension ProfileCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(child: any Coordinator) {
        childCoordinators = childCoordinators.filter { $0.coordinatorType != child.coordinatorType }
    }
}
