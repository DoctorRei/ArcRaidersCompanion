//
//  HomeCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import UIKit

class HomeCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showHomeScreen()
    }
}

private extension HomeCoordinator {
    func showHomeScreen() {
        let vm = HomeView.ViewModel()
        let view = HomeView(viewModel: vm)
        
        let hostingController = HomeHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
}
