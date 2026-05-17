//
//  TradersViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Combine
import Foundation

protocol TradersCoordinatorProtocol: AnyObject {
    func navigateBack()
    func showItemDetails(id: String)
}

extension TradersView {
    protocol ViewModelProtocol {
        func getTraders() async
    }

    final class ViewModel: ObservableObject {
        weak var coordinator: TradersCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var coreDataManager = CoreDataManager()
        private var isErrorLoading = false
        private var favoritesFromCoreData: [String: String] = [:]

        @Published var traders: [TraderModel] = []
    }
}

extension TradersView.ViewModel: TradersView.ViewModelProtocol {
    func getTraders() async {
        Task {
            do {
                loadSavedFavorites()
                let networkTraders = try await networkManager.fetchTraders()
                sortTraders(networkTraders)
            } catch {
                isErrorLoading = true
            }
        }
    }
    
    private func loadSavedFavorites() {
        coreDataManager.fetchAllItems().forEach { item in
            favoritesFromCoreData[item.id] = item.id
        }
    }

    func sortTraders(_ model: [NetworkManager.Model.DataModels.TradersData.Trader]) {
        traders = model.map { trader in
            let items = trader.items
                .map { networkItem -> TraderItemModel in
                    var item = TraderItemModel(networkItem: networkItem)
                    item.isFavorite = favoritesFromCoreData[networkItem.id] != nil
                    return item
                }
                .sorted { $0.rarity.priority > $1.rarity.priority }
            
            return TraderModel(id: trader.id, name: trader.name, items: items)
        }
    }

    func showItemDetails(id: String) {
        coordinator?.showItemDetails(id: id)
    }
}

extension TradersView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}

extension TradersView.ViewModel {
    struct ItemCoreData {
        var id: String
        var name: String
        var icon: String
        var isSelected: Bool
    }
    
    func favoriteButtonPressed(for item: ItemCoreData) {
        switch item.isSelected {
        case true:
            coreDataManager.createItem(id: item.id, name: item.name, icon: item.icon)
        case false:
            coreDataManager.deleteItem(with: item.id)
        }
    }
}
