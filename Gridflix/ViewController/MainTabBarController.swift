//
//  MainTabBarController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 12/09/24.
//

import UIKit

final class MainTabBarController: NiblessTabBarController {

    // MARK: - Properties
    let container: any DependencyContainer

    // MARK: - Lifetime
    init(container: any DependencyContainer) {
        self.container = container
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationControllers: [UINavigationController] = []// container.makeTabViewControllers()
        configureTabBar(for: navigationControllers)
        setViewControllers(navigationControllers, animated: true)
    }

    // MARK: - Private methods
    private func configureTabBar(for controllers: [UINavigationController]) {
        for (controller, item) in zip(controllers, TabItem.allCases) {
            
        }
    }
}

enum TabItem: CaseIterable {
    case home
    case games
    case news
    case profile

    var imageName: String {
        switch self {
        case .home:    return "house"
        case .games:   return "gamecontroller"
        case .news:    return "play.square.stack"
        case .profile: return ""
        }
    }

    var imageType: ImageType {
        switch self {
        case .home, .games, .news: return .system
        case .profile: return .custom
        }
    }
    
    enum ImageType {
        case system
        case custom
    }
}
