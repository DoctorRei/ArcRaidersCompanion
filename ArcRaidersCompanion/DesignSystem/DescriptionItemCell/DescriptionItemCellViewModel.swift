//
//  DescriptionItemCellViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.04.2026.
//

import Foundation

extension Views.DescriptionItemCell {
    enum StatCategory: String, CaseIterable {
        case combat = "Combat"
        case mobility = "Mobility"
        case defense = "Defense"
        case utility = "Utility"
        case weapon = "Weapon"
        case other = "Other"
        
        var icon: String {
            switch self {
            case .combat: return "💥"
            case .mobility: return "🏃"
            case .defense: return "🛡️"
            case .utility: return "🔧"
            case .weapon: return "🔫"
            case .other: return "📊"
            }
        }
    }
    
    enum CellType {
        case baseInfo
        case fullInfo
        case locations
        case guides
    }
    
    struct StatGroup: Identifiable {
        let id = UUID()
        let category: StatCategory
        let stats: [(title: String, value: String)]
    }
}
