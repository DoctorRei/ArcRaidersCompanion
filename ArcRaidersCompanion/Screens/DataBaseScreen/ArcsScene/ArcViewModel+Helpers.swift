//
//  ArcViewModel+Helpers.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

extension Views.ArcInfoView.Models.ArcModel {
    typealias ArcEnemy = NetworkManager.Model.DataModels.ArcsData.ARCEnemy
    typealias Loot = Views.ArcInfoView.Models.ArcModel.ArcLoot
    init(networkArcModel: ArcEnemy) {
        self.id = networkArcModel.id
        self.name = networkArcModel.name
        self.description = networkArcModel.description
        self.icon = networkArcModel.icon
        self.image = networkArcModel.image
        self.loot = networkArcModel.loot?.map { Loot(networkLootModel: $0) } ?? []
    }
}

extension Views.ArcInfoView.Models.ArcModel.ArcLoot {
    typealias Loot = NetworkManager.Model.DataModels.ArcsData.ArcLoot
    init(networkLootModel: Loot) {
        self.id = networkLootModel.id
        self.item = .init(networkLootItemModel: networkLootModel.item)
        self.itemId = networkLootModel.itemId
    }
}

extension Views.ArcInfoView.Models.ArcModel.ArcLoot.LootItem {
    typealias ArcLootItem = NetworkManager.Model.DataModels.ArcsData.LootItem
    init(networkLootItemModel: ArcLootItem) {
        self.icon = networkLootItemModel.icon
        self.id = networkLootItemModel.id
        self.itemType = networkLootItemModel.itemType
        self.name = networkLootItemModel.name
        self.rarity = Rarity(rawValue: networkLootItemModel.rarity) ?? .common
    }
}
extension ArcsView.ViewModel.ArcModel {
    enum EnemyType: String, CaseIterable {
        case ground = "Ground"
        case flying = "Flying"
        case turret = "Turret"
        case boss = "Boss"
        
        var icon: String {
            switch self {
            case .ground: return "figure.walk"
            case .flying: return "paperplane"
            case .turret: return "shield"
            case .boss: return "crown"
            }
        }
    }
}
