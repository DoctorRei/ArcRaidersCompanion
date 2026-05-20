//
//  Models.swift
//  DesignSystem
//
//  Created by Akira Rei on 20.05.2026.
//

import Foundation

extension Views.Models {
    enum ArcModels {}
}

extension Views.Models.ArcModels {
    struct Arc {
        let id: String
        let name: String
        let description: String
        let icon: String
        let image: String
        let loot: [ArcLoot]
    }
}

extension Views.Models.ArcModels.Arc {
    struct ArcLoot {
        let id: String
        let item: LootItem
        let itemId: String
    }
}

extension Views.Models.ArcModels.Arc.ArcLoot {
    struct LootItem {
        let id: String
        let icon: String
        let name: String
        let rarity: Rarity
        let itemType: String
    }
}

extension Views.Models.ArcModels.Arc.ArcLoot.LootItem {
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
    }
}
