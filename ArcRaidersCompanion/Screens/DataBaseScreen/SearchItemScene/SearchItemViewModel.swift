//
//  ArcItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Combine
import Foundation
import DesignSystem

protocol SearchItemNavigateProtocol: AnyObject {
    func navigateBack()
    func showItemDetails(with item: SearchItemView.ViewModel.FoundedItem.Item?)
}

extension SearchItemView {
    protocol ViewModelProtocol {
        func getItems(with searchID: String) async
    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared

        @Published var foundedMiniItems: [Views.Models.ArcModels.Arc.ArcLoot] = []
        @Published var scrollOffset: CGFloat = 0
        @Published var isSearchFocused = false
        @Published var isLoading = false
        @Published var isErrorLoading = false
        @Published var text = ""
        
        private var foundedFullItems: [String: FoundedItem.Item] = [:]
    }
}

extension SearchItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
    
    func navigateToSelectedItem(with id: String) {
        coordinator?.showItemDetails(with: foundedFullItems[id])
    }
}

extension SearchItemView.ViewModel: SearchItemView.ViewModelProtocol {
    func getItems(with searchID: String) async {
        defer { isLoading = false }

        isErrorLoading = false
        isLoading = true

        do {
            let itemsNetwork = try await networkManager.fetchItems(search: searchID)
            let items = itemsNetwork.data.map {
                Views.Models.ArcModels.Arc.ArcLoot(
                    id: $0.id,
                    item: .init(
                        id: $0.id,
                        icon: $0.icon,
                        name: $0.name,
                        rarity: .init(rawValue: $0.rarity) ?? .common,
                        itemType: $0.itemType
                    ),
                    itemId: $0.id
                )
            }

            foundedMiniItems = items
            itemsNetwork.data.forEach { item in
                foundedFullItems[item.id] = .init(data: item)
            }

            if foundedMiniItems.isEmpty {
                isErrorLoading = true
            }

        } catch {
            isErrorLoading = true
        }
    }
}
