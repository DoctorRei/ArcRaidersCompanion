//
//  TraderModels.swift
//  DesignSystem
//
//  Created by Akira Rei on 20.05.2026.
//

import SwiftUI

extension Views.Models {
    public enum TradersModels {}
}

extension Views.Models.TradersModels {
    public struct TraderModel {
        let id: String
        let name: String
    }
    
    public struct TraderItemModel: Identifiable, Equatable {
        public let id: String
        let icon: String
        let name: String
        let value: Int
        let rarity: Rarity
        let itemType: String
        let description: String
        let traderPrice: Int

        var isFavorite: Bool = false
        
        public init(
            id: String,
            icon: String,
            name: String,
            value: Int,
            rarity: Rarity,
            itemType: String,
            description: String,
            traderPrice: Int,
            isFavorite: Bool
        ) {
            self.id = id
            self.icon = icon
            self.name = name
            self.value = value
            self.rarity = rarity
            self.itemType = itemType
            self.description = description
            self.traderPrice = traderPrice
            self.isFavorite = isFavorite
        }
    }

    public enum Rarity: String, CaseIterable {
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
            case .common: return .gray.opacity(0.4)
            case .uncommon: return .green.opacity(0.4)
            case .rare: return .blue.opacity(0.4)
            case .epic: return .purple.opacity(0.4)
            case .legendary: return .yellow.opacity(0.5)
            }
        }
    }
}
