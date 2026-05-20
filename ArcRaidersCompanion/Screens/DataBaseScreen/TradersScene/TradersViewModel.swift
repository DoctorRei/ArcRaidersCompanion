//
//  TradersViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Combine
// TODO: - научиться ебашить отдельно модельки и отдельно вьюхи
import DesignSystem
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
    
    private func clearAndUpdateSavedFavorites() {
        let items = coreDataManager.fetchAllItems()
        var newDict: [String: String] = [:]
        
        items.forEach { item in
            newDict[item.id] = item.id
        }
        
        favoritesFromCoreData = [:]
        favoritesFromCoreData = newDict
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
    
    func updateFavoriteItems() {
        guard !traders.isEmpty else { return }
        clearAndUpdateSavedFavorites()
        let updatedTraders = traders.map { trader in
            let items = trader.items.map { traiderItem in
                var item = traiderItem
                item.isFavorite = favoritesFromCoreData[item.id] != nil
                return item
            }
            return TraderModel(id: trader.id, name: trader.name, items: items)
        }
        traders = updatedTraders
    }
}

extension TradersView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}

extension TradersView.ViewModel {
    public struct ItemCoreData {
        public var id: String
        public var name: String
        public var icon: String
        public var isSelected: Bool
    }
    
    func favoriteButtonPressed(for item: ItemCoreData) {
        switch item.isSelected {
        case true:
            coreDataManager.createItem(id: item.id, name: item.name, icon: item.icon)
        case false:
            coreDataManager.deleteItem(with: item.id)
        }
    }
    
    func returnTraderModel(for item: TraderItemModel) -> Views.Models.TradersModels.TraderItemModel {
        .init(
            id: item.id,
            icon: item.icon,
            name: item.name,
            value: item.value,
            rarity: .init(rawValue: item.rarity.rawValue) ?? .common,
            itemType: item.itemType,
            description: item.description,
            traderPrice: item.traderPrice,
            isFavorite: item.isFavorite
        )
    }
}
