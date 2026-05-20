//
//  ArcLootCellViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

public extension Views.Models.ArcModels.Arc.ArcLoot.LootItem {
    public var color: Color {
        switch rarity {
        case .common:
                .gray.opacity(0.4)
        case .uncommon:
                .green.opacity(0.4)
        case .rare:
                .blue.opacity(0.4)
        case .epic:
                .purple.opacity(0.4)
        case .legendary:
                .yellow.opacity(0.5)
        }
    }
}
