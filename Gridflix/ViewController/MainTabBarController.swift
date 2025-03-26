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
        let navigationControllers: [UINavigationController] = container.mainPresenter.makeTabViewControllers()
        configureTabBar(for: navigationControllers)
        setViewControllers(navigationControllers, animated: true)
    }

    // MARK: - Private methods
    private func configureTabBar(for controllers: [UINavigationController]) {
        for (controller, item) in zip(controllers, TabItem.allCases) {
            let tabBarItem = UITabBarItem(
                title: item.title,
                image: UIImage(systemName: item.imageName),
                selectedImage: UIImage(systemName: item.imageName + ".fill")
            )
            controller.tabBarItem = tabBarItem
        }
    }
}

enum TabItem: CaseIterable {
    case home
    case games
    case news
    case profile

    var title: String {
        switch self {
        case .home:    return "Home"
        case .games:   return "Games"
        case .news:    return "News"
        case .profile: return "Profile"
        }
    }

    var imageName: String {
        switch self {
        case .home:    return "house"
        case .games:   return "gamecontroller"
        case .news:    return "play.square.stack"
        case .profile: return "person"
        }
    }

    var imageType: ImageType {
        switch self {
        case .home, .games, .news, .profile: return .system
        }
    }
    
    enum ImageType {
        case system
        case custom
    }
}
