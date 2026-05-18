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
    protocol ViewModelProtocol {
        func loadItem(id: String) async
    }

    final class ViewModel: ObservableObject {
        weak var coordinator: SelectedItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        private var coreDataManager = CoreDataManager()

        @Published var item: SearchItemView.ViewModel.FoundedItem.Item?
        @Published var isLoading = false
        @Published var isFavorite = false

        init(
            coordinator: SelectedItemNavigateProtocol? = nil,
            networkManager: NetworkManager = NetworkManager.shared,
            navigateWith: SelectedItemCoordinator.NavigateWith,
        ) {
            self.coordinator = coordinator
            self.networkManager = networkManager
            switch navigateWith {
            case .itemData(let item):
                self.item = item
            case .id(let id):
                Task {
                    await loadItem(id: id)
                }
            }
        }

        var hasBasicInfo: Bool {
            guard let item = item else { return false }
            return item.workbench != nil ||
            item.ammoType != nil ||
            item.shieldType != nil ||
            item.subcategory != nil ||
            !item.loadoutSlots.isEmpty
        }

        var hasStats: Bool {
            guard let item = item else { return false }
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
            guard let item = item else { return false }
            return !item.locations.isEmpty
        }

        var hasGuides: Bool {
            guard let item = item else { return false }
            return !item.guideLinks.isEmpty
        }

        var hasLocationsOrGuides: Bool {
            hasLocations || hasGuides
        }
    }
}

extension SelectedItemView.ViewModel {
    func loadItem(id: String) async {
        await MainActor.run { isLoading = true }
        do {
            let networkItem = try await networkManager.fetchItem(id: id)
            let favoriteItem = coreDataManager.fetchItem(for: networkItem.id)
            if let _ = favoriteItem?.id {
                self.isFavorite = true
            }
            let convertedItem = SearchItemView.ViewModel.FoundedItem.Item(data: networkItem)
            await MainActor.run {
                self.item = convertedItem
                self.isLoading = false
            }
        } catch {
            await MainActor.run { isLoading = false }
            print("Error loading item: \(error)")
        }
    }
    
    func favoriteButtonPressed() {
        guard let item else { return }
        switch isFavorite {
        case true:
            coreDataManager.createItem(id: item.id, name: item.name, icon: item.icon)
        case false:
            coreDataManager.deleteItem(with: item.id)
        }
    }
    
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
