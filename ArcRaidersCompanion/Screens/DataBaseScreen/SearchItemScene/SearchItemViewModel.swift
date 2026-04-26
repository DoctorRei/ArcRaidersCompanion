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
        func getItems() async
    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false
        
        @Published var foundedItems: [Views.ArcInfoView.Models.ArcModel.ArcLoot] = []
        @Published var isSearchFocused = false
        @Published var text = ""
        @Published var scrollOffset: CGFloat = 0
    }
}

extension SearchItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}

extension SearchItemView.ViewModel: SearchItemView.ViewModelProtocol {
    func getItems() async {
        do {
            let item = try await networkManager.fetchItem(id: "acoustic-guitar")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getItems(with searchID: String) async {
        do {
            let itemsNetwork = try await networkManager.fetchItems(search: searchID)
            let items = itemsNetwork.data.map {
                Views.ArcInfoView.Models.ArcModel.ArcLoot(
                    id: $0.id,
                    item: .init(id: $0.id, icon: $0.icon, name: $0.name, rarity: .legendary, itemType: $0.itemType),
                    itemId: $0.id
                )
            }
            foundedItems = items
            print(items)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SearchItemView.ViewModel {
    struct ItemModel {
        let id: String
        let image: String
        
    }
}
