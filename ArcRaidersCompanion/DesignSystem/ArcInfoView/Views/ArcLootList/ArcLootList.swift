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
        var completion: (Models.ArcModel.ArcLoot.LootItem) -> Void
        
        init(
            lootList: [Models.ArcModel.ArcLoot],
            completion: @escaping (Models.ArcModel.ArcLoot.LootItem) -> Void
        ) {
            self.lootList = lootList.sorted { $0.item.rarity.priority > $1.item.rarity.priority }
            self.completion = completion
        }
        
        var body: some View {
            LazyVStack(spacing: 2) {
                ForEach(lootList, id: \.id) { item in
                    ArcLootCell(lootModel: item.item) { selectedItem in
                        completion(selectedItem)
                    }
                }
            }
        }
    }
}
