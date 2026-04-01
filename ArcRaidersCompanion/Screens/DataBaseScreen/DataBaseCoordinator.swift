//
//  DataBaseCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import UIKit

protocol DataBaseCoordinatorProtocol: AnyObject {
    func showArcsScene()
}

class DataBaseCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showDataBaseScreen()
    }
}

extension DataBaseCoordinator: DataBaseCoordinatorProtocol {
    func showDataBaseScreen() {
        let vm = DataBaseView.ViewModel()
        vm.coordinator = self
        let view = DataBaseView(viewModel: vm)
        
        let hostingController = DataBaseHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
    
    func showArcsScene() {
        let vm = ArcsView.ViewModel()
        let view = ArcsView(viewModel: vm)
        
        let hostingController = ArcsHostingController(rootView: view, viewModel: vm)
        
        presenter.pushViewController(hostingController, animated: true)
    }
}

