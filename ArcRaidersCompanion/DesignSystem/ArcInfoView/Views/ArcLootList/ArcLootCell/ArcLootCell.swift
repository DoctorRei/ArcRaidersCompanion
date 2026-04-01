//
//  ArcLoot.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

extension Views.ArcInfoView.ArcLootList {
    struct ArcLootCell: View {
        let lootModel: Views.ArcInfoView.Models.ArcModel.ArcLoot.LootItem

        var body: some View {
            content()
                .background(lootModel.color)
        }
    }
}

extension Views.ArcInfoView.ArcLootList.ArcLootCell {
    func content() -> some View {
        HStack {
            KFImageView(url: URL(string: lootModel.icon))
                .frame(width: 24, height: 24)
            Text(lootModel.name)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
