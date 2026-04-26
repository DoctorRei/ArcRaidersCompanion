//
//  ArcItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Combine
import Foundation

protocol SearchItemNavigateProtocol: AnyObject {
    func navigateBack()
    func showItemDetails()
}

extension SearchItemView {
    protocol ViewModelProtocol {
        func getItems(with searchID: String) async
    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        
        @Published var foundedItems: [Views.ArcInfoView.Models.ArcModel.ArcLoot] = []
        @Published var isSearchFocused = false
        @Published var isLoading = false
        @Published var isErrorLoading = false
        @Published var text = ""
        @Published var scrollOffset: CGFloat = 0
    }
}

extension SearchItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
    
    func navigateToSelectedItem() {
        coordinator?.showItemDetails()
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
                Views.ArcInfoView.Models.ArcModel.ArcLoot(
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
            foundedItems = items

            if foundedItems.isEmpty {
                isErrorLoading = true
            }

        } catch {
            isErrorLoading = true
        }
    }
}
