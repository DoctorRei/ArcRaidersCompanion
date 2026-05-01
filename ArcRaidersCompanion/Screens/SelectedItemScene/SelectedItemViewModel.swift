//
//  SelectedItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import Combine
import Foundation

protocol SelectedItemNavigateProtocol: AnyObject {
    func navigateBack()
}

extension SelectedItemView {
    protocol ViewModelProtocol {}
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SelectedItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        
        @Published var item: SearchItemView.ViewModel.FoundedItem.Item
        @Published var isExpandedBasicInfo: Bool = false
        @Published var isExpandedItemCharacteristics: Bool = false
        
        init(
            coordinator: SelectedItemNavigateProtocol? = nil,
            networkManager: NetworkManager = NetworkManager.shared,
            item: SearchItemView.ViewModel.FoundedItem.Item
        ) {
            self.coordinator = coordinator
            self.networkManager = networkManager
            self.item = item
        }
        
        func printTest() {
            print("TESTTEST \(item)")
        }
    }
}

extension SelectedItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
