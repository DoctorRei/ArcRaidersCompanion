//
//  SelectedItemCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import UIKit

class SelectedItemCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showSelectedItemScene()
    }
}

private extension SelectedItemCoordinator {
    func showSelectedItemScene() {
        let vm = SelectedItemView.ViewModel()
        let view = SelectedItemView(viewModel: vm)
        
        let hostingController = SelectedItemHostingController(rootView: view, viewModel: vm)
        presenter.pushViewController(hostingController, animated: true)
    }
}

extension SelectedItemCoordinator: SelectedItemNavigateProtocol {
    func navigateBack() {
        presenter.popViewController(animated: true)
    }
}
