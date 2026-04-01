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
        
        init(lootList: [Models.ArcModel.ArcLoot]) {
            self.lootList = lootList.sorted { $0.item.rarity.priority > $1.item.rarity.priority }
        }
        
        var body: some View {
            LazyVStack(spacing: 2) {
                ForEach(lootList, id: \.id) { item in
                    ArcLootCell(lootModel: item.item)
                }
            }
        }
    }
}
