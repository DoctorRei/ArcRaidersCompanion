//
//  ArcInfoCell+Model.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

extension Views.ArcInfoView {
    enum Models {
        struct ArcModel {
            let id: String
            let name: String
            let description: String
            let icon: String
            let image: String
            let loot: [ArcLoot]
        }
    }
}

extension Views.ArcInfoView.Models.ArcModel {
    struct ArcLoot: Decodable {
        let id: String
        let item: LootItem
        let itemId: String
    }
}

extension Views.ArcInfoView.Models.ArcModel.ArcLoot {
    struct LootItem: Decodable {
        let id: String
        let icon: String
        let name: String
        let rarity: String
        let itemType: String
    }
}
