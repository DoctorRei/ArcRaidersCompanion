//
//  DataBaseCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import UIKit

class DataBaseCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showDataBaseScreen()
    }
}

private extension DataBaseCoordinator {
    func showDataBaseScreen() {
        let vm = DataBaseView.ViewModel()
        let view = DataBaseView(viewModel: vm)
        
        let hostingController = DataBaseHostingController(rootView: view, viewModel: vm)
        
        presenter.setViewControllers([hostingController], animated: true)
    }
}

