//
//  MainCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import UIKit

class BaseCoordinator<ControllerType> where ControllerType: UIViewController {
    let id = UUID()
    var presenter: ControllerType
    
    private(set) var childCoordinators = [UUID: Any]()
    
    init(presenter: ControllerType) {
        self.presenter = presenter
    }
    
    func start() {}
}

extension BaseCoordinator{
    func store<U: UIViewController>(coordinator: BaseCoordinator<U>) {
        let coordinatorExists = childCoordinators.contains(where: {(key, value) -> Bool in
            return key == coordinator.id
        })
        
        if !coordinatorExists {
            childCoordinators[coordinator.id] = coordinator
        }
    }
    
    func free<U: UIViewController>(coordinator: BaseCoordinator<U>) {
        let coordinatorExists = childCoordinators.contains(where: {(key, value) -> Bool in
            return key == coordinator.id
        })
        
        if coordinatorExists {
            childCoordinators[coordinator.id] = nil
        }
    }
    
    func freeAllCoordinators() {
        childCoordinators = [UUID: Any]()
    }
    
    func childCoordinator<T>(for key: UUID) -> T? {
        return childCoordinators.first(where: { $0.key == key })?.value as? T
    }
}
