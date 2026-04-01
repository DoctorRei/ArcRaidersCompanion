//
//  ArcLootCellViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

extension Views.ArcInfoView.Models.ArcModel.ArcLoot.LootItem {
    var rarityColor: Color {
        switch rarity {
        case "Rare":
                .blue.opacity(0.4)
        case "Uncommon":
                .green.opacity(0.4)
        default:
                .white
        }
    }
}
