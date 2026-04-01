//
//  ArcLootCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

extension Views.ArcInfoView {
    struct ArcLootList: View {
        var lootList: [Models.ArcModel.ArcLoot]
        
        var body: some View {
            List(lootList, id: \.id) { loot in
                ArcLootCell(
                    lootModel: .init(
                        id: loot.item.id,
                        icon: loot.item.icon,
                        name: loot.item.name,
                        rarity: loot.item.rarity,
                        itemType: loot.item.itemType
                    )
                )
            }
        }
    }
}
