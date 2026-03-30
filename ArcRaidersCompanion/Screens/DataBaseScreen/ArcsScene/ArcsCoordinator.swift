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
        let view = ArcsView(viewModel: vm)
        
        let hostingController = ArcsHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
}

