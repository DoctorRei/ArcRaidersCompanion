//
//  ArcItemCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import UIKit

class SearchItemCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        showSearchItemScene()
    }
}

private extension SearchItemCoordinator {
    func showSearchItemScene() {
        let vm = SearchItemView.ViewModel()
        vm.coordinator = self
        let view = SearchItemView(viewModel: vm)
        
        let hostingController = SearchItemHostingController(rootView: view, viewModel: vm)

        presenter.pushViewController(hostingController, animated: true)
    }
}

extension SearchItemCoordinator: SearchItemNavigateProtocol {
    func showItemDetails(with item: SearchItemView.ViewModel.FoundedItem.Item?) {
        guard let item else { return }
        let coordinator = SelectedItemCoordinator(presenter: presenter, selectedItem: item)
        coordinator.start()
        
        store(coordinator: coordinator)
    }
    
    func navigateBack() {
        presenter.popViewController(animated: true)
    }
}
