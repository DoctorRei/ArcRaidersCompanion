//
//  DescriptionItemCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.04.2026.
//

import SwiftUI

extension Views {
    struct DescriptionItemCell: View {
        let itemModel: SearchItemView.ViewModel.FoundedItem.Item
        let selectedType: CellType
        
        var body: some View {
            content()
        }
    }
}

extension Views.DescriptionItemCell {
    @ViewBuilder
    func content() -> some View {
        switch selectedType {
        case .baseInfo:
            baseInfoCell()
        case .fullInfo:
            fullInfoCell()
        }
    }
    
    func baseInfoCell() -> some View {
        VStack(alignment: .leading) {
            statRow(title: "Price", value: itemModel.value.description)
            if let workbench = itemModel.workbench {
                statRow(title: "Workbench", value: workbench)
            }
            if let ammoType = itemModel.ammoType {
                statRow(title: "Ammo Type", value: ammoType)
            }
            if let shieldType = itemModel.shieldType {
                statRow(title: "Shield Type", value: shieldType)
            }
            if let subcategory = itemModel.subcategory {
                statRow(title: "Subcategory", value: subcategory)
            }
            if !itemModel.loadoutSlots.isEmpty {
                listOfDescription(for: itemModel.loadoutSlots)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
        )
    }
    
    func listOfDescription(for array: [String]) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Loadout slots: ")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 150, alignment: .leading)
            VStack(alignment: .leading) {
                ForEach(array, id: \.hashValue) { description in
                    Text(description)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

extension Views.DescriptionItemCell {
    func fullInfoCell() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if groupedStats.isEmpty {
                Text("No characteristics available")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(groupedStats) { group in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text(group.category.icon)
                                .font(.title3)
                            Text(group.category.rawValue)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        
                        // Статы группы
                        VStack(spacing: 0) {
                            ForEach(group.stats, id: \.title) { stat in
                                statRow(title: stat.title, value: stat.value, isDeviderNeeded: stat.title != group.stats.last?.title)
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                    )
                }
            }
        }
        .padding(.vertical)
    }
    
    @ViewBuilder
    func statRow(title: String, value: String, isDeviderNeeded: Bool = false) -> some View {
        if !value.isEmpty {
            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Text("\(title):")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(width: 150, alignment: .leading)
                    
                    Text(value)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                }
                if isDeviderNeeded {
                    Divider()
                        .padding(.horizontal)
                }
            }
        }
    }
}

extension Views.DescriptionItemCell {
    var statsFromReflection: [(title: String, value: String)] {
        let mirror = Mirror(reflecting: itemModel.statBlock)
        
        return mirror.children.compactMap { child -> (String, String)? in
            guard let label = child.label else { return nil }
            
            let formattedTitle = label
                .replacingOccurrences(of: "_", with: " ")
                .split(separator: " ")
                .map { $0.capitalized }
                .joined(separator: " ")
            
            // Обрабатываем разные типы с фильтрацией нулей
            switch child.value {
            case let value as Int:
                guard value != 0 else { return nil } // Фильтруем 0
                return (formattedTitle, "\(value)")
            case let value as Double:
                guard value != 0.0 else { return nil } // Фильтруем 0.0
                return (formattedTitle, String(format: "%.1f", value))
            case let value as String:
                return value.isEmpty ? nil : (formattedTitle, value)
            default:
                return nil
            }
        }
        .sorted { $0.title < $1.title }
    }
    
    // MARK: - Grouped Stats
    var groupedStats: [StatGroup] {
        let stats = statsFromReflection
        var groups: [StatCategory: [(String, String)]] = [:]
        
        for stat in stats {
            let category = categorizeStat(stat.title)
            groups[category, default: []].append((stat.title, stat.value))
        }
        
        return StatCategory.allCases.compactMap { category in
            guard let stats = groups[category], !stats.isEmpty else { return nil }
            return StatGroup(category: category, stats: stats)
        }
        .filter { !$0.stats.isEmpty } // Дополнительная проверка на пустоту
    }
    
    private func categorizeStat(_ title: String) -> StatCategory {
        let lowercased = title.lowercased()
        
        if lowercased.contains("damage") ||
            lowercased.contains("fire rate") ||
            lowercased.contains("range") ||
            lowercased.contains("magazine") ||
            lowercased.contains("projectile") ||
            lowercased.contains("firing") ||
            lowercased.contains("ammo") ||
            lowercased.contains("bullet") ||
            lowercased.contains("stun") {
            return .combat
        }
        
        if lowercased.contains("agility") ||
            lowercased.contains("weight") ||
            lowercased.contains("movement") ||
            lowercased.contains("stamina") ||
            lowercased.contains("ads") ||
            lowercased.contains("speed") {
            return .mobility
        }
        
        if lowercased.contains("health") ||
            lowercased.contains("shield") ||
            lowercased.contains("mitigation") ||
            lowercased.contains("defense") {
            return .defense
        }
        
        if lowercased.contains("healing") ||
            lowercased.contains("duration") ||
            lowercased.contains("use time") ||
            lowercased.contains("slots") ||
            lowercased.contains("stack") ||
            lowercased.contains("augment") ||
            lowercased.contains("backpack") ||
            lowercased.contains("safe pocket") ||
            lowercased.contains("quick use") {
            return .utility
        }
        
        if lowercased.contains("recoil") ||
            lowercased.contains("dispersion") ||
            lowercased.contains("reload") ||
            lowercased.contains("equip") ||
            lowercased.contains("durability") ||
            lowercased.contains("illumination") {
            return .weapon
        }
        
        return .other
    }
}
