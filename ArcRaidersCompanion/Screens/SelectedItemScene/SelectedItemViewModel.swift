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
        
        init(
            coordinator: SelectedItemNavigateProtocol? = nil,
            networkManager: NetworkManager = NetworkManager.shared,
            item: SearchItemView.ViewModel.FoundedItem.Item
        ) {
            self.coordinator = coordinator
            self.networkManager = networkManager
            self.item = item
        }
        
        var hasBasicInfo: Bool {
            item.workbench != nil ||
            item.ammoType != nil ||
            item.shieldType != nil ||
            item.subcategory != nil ||
            !item.loadoutSlots.isEmpty
        }

        var hasStats: Bool {
            let mirror = Mirror(reflecting: item.statBlock)
            for child in mirror.children {
                switch child.value {
                case let val as Int: if val != 0 { return true }
                case let val as Double: if val != 0.0 { return true }
                case let val as String: if !val.isEmpty { return true }
                default: break
                }
            }
            return false
        }

        var hasLocations: Bool {
            !item.locations.isEmpty
        }

        var hasGuides: Bool {
            !item.guideLinks.isEmpty
        }

        var hasLocationsOrGuides: Bool {
            hasLocations || hasGuides
        }
    }
}

extension SelectedItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
