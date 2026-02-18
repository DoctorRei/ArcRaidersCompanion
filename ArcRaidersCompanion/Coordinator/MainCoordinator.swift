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

class MainCoordinator: BaseCoordinator<UINavigationController> {
    weak var delegate: MainCoordinatorDelegate?
    
    override func start() {
        showTabBarView()
    }
}

private extension MainCoordinator {
    func showTabBarView() {
        let homeScreen = configureHomeScreen()
        let favoritesScreen = configureFavoritesScreen()
        
        let controllers = [
            homeScreen,
            favoritesScreen
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: false)
        
        presenter.setViewControllers([tabBarController], animated: true)
    }
}

private extension MainCoordinator {
    func configureHomeScreen() -> UINavigationController {
        let flowPresenter = UINavigationController()
        let coordinator = HomeCoordinator(presenter: flowPresenter)
        flowPresenter.tabBarItem = UITabBarItem(
            title: "Home",
            image: .init(systemName: "heart"),
            tag: TabBarTag.home.rawValue
        )

        coordinator.start()
        store(coordinator: coordinator)
        
        return coordinator.presenter
    }
    
    func configureFavoritesScreen() -> UINavigationController {
        let flowPresenter = UINavigationController()
        let coordinator = FavoritesCoordinator(presenter: flowPresenter)
        flowPresenter.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: .init(systemName: "heart.fill"),
            tag: TabBarTag.favorites.rawValue
        )

        coordinator.start()
        store(coordinator: coordinator)
        
        return coordinator.presenter
    }
}
