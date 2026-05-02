//
//  TradersCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import UIKit

class TradersCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showTradersScene()
    }
}

private extension TradersCoordinator {
    func showTradersScene() {
        let vm = TradersView.ViewModel()
        vm.coordinator = self
        let view = TradersView(viewModel: vm)

        let hostingController = TradersHostingController(rootView: view, viewModel: vm)

        presenter.setViewControllers([hostingController], animated: true)
    }
}

extension TradersCoordinator: TradersCoordinatorProtocol {
    func navigateBack() {
        presenter.popViewController(animated: true)
    }
}
