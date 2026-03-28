//
//  MainCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func onMainCoordinatorComplete(coordinator: MainCoordinator)
}

enum TabBarTag: Int {
    case home
    case favorites
}

class MainCoordinator: BaseCoordinator<UITabBarController> {
    weak var delegate: MainCoordinatorDelegate?
    
    override func start() {
        configureTabs()
    }
    
    private func configureTabs() {
        let homeViewController = configureHomeScreen()
        let favoritesViewController = configureFavoritesScreen()
        
        presenter.viewControllers = [homeViewController, favoritesViewController]
    }
}

private extension MainCoordinator {
    func configureHomeScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let coordinator = HomeCoordinator(presenter: navigationController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Home",
            image: .init(systemName: "heart"),
            tag: TabBarTag.home.rawValue
        )
        
        coordinator.start()
        store(coordinator: coordinator)
        
        return navigationController
    }
    
    func configureFavoritesScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let coordinator = FavoritesCoordinator(presenter: navigationController)
        navigationController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: .init(systemName: "heart.fill"),
            tag: TabBarTag.favorites.rawValue
        )
        
        coordinator.start()
        store(coordinator: coordinator)
        
        return navigationController
    }
}
