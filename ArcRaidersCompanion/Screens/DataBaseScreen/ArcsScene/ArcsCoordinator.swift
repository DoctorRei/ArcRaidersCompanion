//
//  ArcsCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import UIKit

class ArcsCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showArcsScene()
    }
}

private extension ArcsCoordinator {
    func showArcsScene() {
        let vm = ArcsView.ViewModel()
        vm.coordinator = self
        let view = ArcsView(viewModel: vm)
        
        let hostingController = ArcsHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
}

extension ArcsCoordinator: ArcsCoordinatorProtocol {
    func navigateBack() {
        presenter.popViewController(animated: true)
    }
}

