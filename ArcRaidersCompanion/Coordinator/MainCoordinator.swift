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
    case dataBase
    case favorites
}

class MainCoordinator: BaseCoordinator<UITabBarController> {
    private enum Const {
        static let eventsTabName = "Events"
        static let dataBaseTabName = "DataBase"
        static let favoritesTabName = "Favorites"
    }
    
    weak var delegate: MainCoordinatorDelegate?
    
    override func start() {
        configureTabs()
    }
    
    private func configureTabs() {
        let homeViewController = configureHomeScreen()
        let favoritesViewController = configureFavoritesScreen()
        let dataBaseViewController = configureDataBaseScreen()
        
        presenter.viewControllers = [homeViewController, dataBaseViewController, favoritesViewController]
    }
}

private extension MainCoordinator {
    func configureHomeScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let coordinator = HomeCoordinator(presenter: navigationController)
        navigationController.tabBarItem = UITabBarItem(
            title: Const.eventsTabName,
            image: .init(systemName: "heart"),
            tag: TabBarTag.home.rawValue
        )
        
        coordinator.start()
        store(coordinator: coordinator)
        
        return navigationController
    }
    
    func configureDataBaseScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let coordinator = DataBaseCoordinator(presenter: navigationController)
        navigationController.tabBarItem = UITabBarItem(
            title: Const.dataBaseTabName,
            image: .init(systemName: "heart"),
            tag: TabBarTag.dataBase.rawValue
        )
        
        coordinator.start()
        store(coordinator: coordinator)
        
        return navigationController
    }
    
    func configureFavoritesScreen() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let coordinator = FavoritesCoordinator(presenter: navigationController)
        navigationController.tabBarItem = UITabBarItem(
            title: Const.favoritesTabName,
            image: .init(systemName: "heart.fill"),
            tag: TabBarTag.favorites.rawValue
        )
        
        coordinator.start()
        store(coordinator: coordinator)
        
        return navigationController
    }
}
