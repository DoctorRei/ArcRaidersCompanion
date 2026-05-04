//
//  SelectedItemCoordinator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import UIKit

class SelectedItemCoordinator: BaseCoordinator<UINavigationController> {
    enum NavigateWith {
        case itemData(SearchItemView.ViewModel.FoundedItem.Item)
        case id(String)
    }
    
    typealias Item = SearchItemView.ViewModel.FoundedItem.Item
    private let selectedNavigate: NavigateWith

    override func start() {
        showSelectedItemScene()
    }
    
    init(presenter: UINavigationController, navigateWith: NavigateWith) {
        self.selectedNavigate = navigateWith
        super.init(presenter: presenter)
    }
}

private extension SelectedItemCoordinator {
    func showSelectedItemScene() {
        let vm = SelectedItemView.ViewModel(navigateWith: selectedNavigate)
        vm.coordinator = self
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
