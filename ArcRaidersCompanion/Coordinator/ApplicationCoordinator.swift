//
//  ApplicationCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator<UINavigationController> {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        let presenter = UINavigationController()
        super.init(presenter: presenter)
        
        self.window.rootViewController = presenter
        self.window.makeKeyAndVisible()
    }
    
    override func start() {
        let mainCoordinator = MainCoordinator(presenter: presenter)
        mainCoordinator.start()
        
        self.store(coordinator: mainCoordinator)
    }
}
