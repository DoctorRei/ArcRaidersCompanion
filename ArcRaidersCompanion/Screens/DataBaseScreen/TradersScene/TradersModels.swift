//
//  TradersModels.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension TradersView {
    struct TraderModel: Identifiable {
        let id: String
        let name: String
        let items: [TraderItemModel]
    }

    struct TraderItemModel: Identifiable {
        let id: String
        let icon: String
        let name: String
        let value: Int
        let rarity: String
        let itemType: String
        let description: String
        let traderPrice: Int
    }
}

extension TradersView.TraderModel {
    init(networkTrader: NetworkManager.Model.DataModels.TradersData.Trader) {
        self.id = networkTrader.id
        self.name = networkTrader.name
        self.items = networkTrader.items.map { TradersView.TraderItemModel(networkItem: $0) }
    }
}

extension TradersView.TraderItemModel {
    init(networkItem: NetworkManager.Model.DataModels.TradersData.TraderItem) {
        self.id = networkItem.id
        self.icon = networkItem.icon
        self.name = networkItem.name
        self.value = networkItem.value
        self.rarity = networkItem.rarity
        self.itemType = networkItem.itemType
        self.description = networkItem.description
        self.traderPrice = networkItem.traderPrice
    }
}
