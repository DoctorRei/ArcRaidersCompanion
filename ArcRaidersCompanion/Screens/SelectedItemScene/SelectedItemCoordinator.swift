//
//  SelectedItemCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import UIKit

class SelectedItemCoordinator: BaseCoordinator<UINavigationController> {
    typealias Item = SearchItemView.ViewModel.FoundedItem.Item
    private let selectedItem: Item
    
    override func start() {
        showSelectedItemScene()
    }
    
    init(presenter: UINavigationController, selectedItem: Item) {
        self.selectedItem = selectedItem
        super.init(presenter: presenter)
    }
}

private extension SelectedItemCoordinator {
    func showSelectedItemScene() {
        let vm = SelectedItemView.ViewModel(item: selectedItem)
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
