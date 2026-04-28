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
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        
        private let item: SearchItemView.ViewModel.FoundedItem.Item
        
        init(
            coordinator: SearchItemNavigateProtocol? = nil,
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
