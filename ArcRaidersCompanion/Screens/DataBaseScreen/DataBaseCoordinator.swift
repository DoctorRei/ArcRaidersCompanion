//
//  DataBaseCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import UIKit

protocol DataBaseCoordinatorProtocol: AnyObject {
    func showArcsScene()
    func showTradersScene()
    func showSearchItemScene()
    func showSelectedItemView(item: SelectedItemCoordinator.Item)
}

class DataBaseCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showDataBaseScreen()
    }
}

extension DataBaseCoordinator: ArcsCoordinatorProtocol, TradersCoordinatorProtocol {
    func navigateBack() {
        presenter.popViewController(animated: true)
    }
}

extension DataBaseCoordinator: DataBaseCoordinatorProtocol {
    func showSelectedItemView(item: SelectedItemCoordinator.Item) {
        let coordinator = SelectedItemCoordinator(presenter: presenter, selectedItem: item)
        coordinator.start()

        store(coordinator: coordinator)
    }

    func showSearchItemScene() {
        let coordinator = SearchItemCoordinator(presenter: presenter)
        coordinator.start()

        store(coordinator: coordinator)
    }

    func showDataBaseScreen() {
        let vm = DataBaseView.ViewModel()
        vm.coordinator = self
        let view = DataBaseView(viewModel: vm)
        let hostingController = DataBaseHostingController(rootView: view, viewModel: vm)
        presenter.setViewControllers([hostingController], animated: true)
    }

    func showArcsScene() {
        let vm = ArcsView.ViewModel()
        vm.coordinator = self
        let view = ArcsView(viewModel: vm)
        let hostingController = ArcsHostingController(rootView: view, viewModel: vm)
        presenter.pushViewController(hostingController, animated: true)
    }

    func showTradersScene() {
        let vm = TradersView.ViewModel()
        vm.coordinator = self
        let view = TradersView(viewModel: vm)
        let hostingController = TradersHostingController(rootView: view, viewModel: vm)
        presenter.pushViewController(hostingController, animated: true)
    }
}

