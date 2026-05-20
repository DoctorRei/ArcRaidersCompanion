//
//  Models.swift
//  DesignSystem
//
//  Created by Akira Rei on 20.05.2026.
//

import Foundation

extension Views.Models {
    public enum ArcModels {}
}

extension Views.Models.ArcModels {
    public struct Arc {
        public let id: String
        public let name: String
        public let description: String
        public let icon: String
        public let image: String
        public let loot: [ArcLoot]
        
        public init(
            id: String,
            name: String,
            description: String,
            icon: String,
            image: String,
            loot: [ArcLoot]
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.icon = icon
            self.image = image
            self.loot = loot
        }
    }
}

extension Views.Models.ArcModels.Arc {
    public struct ArcLoot: Identifiable {
        public let id: String
        public let item: LootItem
        public let itemId: String
        
        public init(id: String, item: LootItem, itemId: String) {
            self.id = id
            self.item = item
            self.itemId = itemId
        }
    }
}

extension Views.Models.ArcModels.Arc.ArcLoot {
    public struct LootItem: Identifiable {
        public let id: String
        public let icon: String
        public let name: String
        public let rarity: Rarity
        public let itemType: String
        
        public init(id: String, icon: String, name: String, rarity: Rarity, itemType: String) {
            self.id = id
            self.icon = icon
            self.name = name
            self.rarity = rarity
            self.itemType = itemType
        }
    }
}

extension Views.Models.ArcModels.Arc.ArcLoot.LootItem {
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
    }
}
