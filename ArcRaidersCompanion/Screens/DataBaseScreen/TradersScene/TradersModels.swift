//
//  TradersModels.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation
import SwiftUI

extension TradersView.ViewModel {
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
        let rarity: Rarity
        let itemType: String
        let description: String
        let traderPrice: Int
    }

    enum Rarity: String, CaseIterable {
        case common = "Common"
        case uncommon = "Uncommon"
        case rare = "Rare"
        case epic = "Epic"
        case legendary = "Legendary"

        var priority: Int {
            switch self {
            case .common: return 0
            case .uncommon: return 1
            case .rare: return 2
            case .epic: return 3
            case .legendary: return 4
            }
        }

        var color: Color {
            switch self {
            case .common: return .white
            case .uncommon: return .green.opacity(0.4)
            case .rare: return .blue.opacity(0.4)
            case .epic: return .purple.opacity(0.4)
            case .legendary: return .yellow.opacity(0.5)
            }
        }
    }
}

extension TradersView.ViewModel.TraderModel {
    init(networkTrader: NetworkManager.Model.DataModels.TradersData.Trader) {
        self.id = networkTrader.id
        self.name = networkTrader.name
        self.items = networkTrader.items.map { TradersView.ViewModel.TraderItemModel(networkItem: $0) }
    }
}

extension TradersView.ViewModel.TraderItemModel {
    init(networkItem: NetworkManager.Model.DataModels.TradersData.TraderItem) {
        self.id = networkItem.id
        self.icon = networkItem.icon
        self.name = networkItem.name
        self.value = networkItem.value
        self.rarity = TradersView.ViewModel.Rarity(rawValue: networkItem.rarity) ?? .common
        self.itemType = networkItem.itemType
        self.description = networkItem.description
        self.traderPrice = networkItem.traderPrice
    }
}
