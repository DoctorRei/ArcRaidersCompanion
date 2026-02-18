//
//  FavoritesCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import UIKit

class FavoritesCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showFavoritesScreen()
    }
}

private extension FavoritesCoordinator {
    func showFavoritesScreen() {
        let vm = FavoritesView.ViewModel()
        let view = FavoritesView(viewModel: vm)
        
        let hostingController = FavoritesHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
}
