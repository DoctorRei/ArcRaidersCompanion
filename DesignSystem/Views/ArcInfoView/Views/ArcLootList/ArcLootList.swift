//
//  ArcLootCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

extension Views.ArcInfoView {
    struct ArcLootList: View {
        typealias ArcLoot = Views.Models.ArcModels.Arc.ArcLoot
        
        var lootList: [ArcLoot]
        var completion: (ArcLoot.LootItem) -> Void
        
        init(
            lootList: [ArcLoot],
            completion: @escaping (ArcLoot.LootItem) -> Void
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
