//
//  DescriptionItemCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.04.2026.
//
import SwiftUI

extension Views {
    struct DescriptionItemCell: View {
        
        // MARK: - Constants
        private enum Const {
            enum Titles {
                static let price: String = "Price"
                static let workbench: String = "Workbench"
                static let ammoType: String = "Ammo Type"
                static let shieldType: String = "Shield Type"
                static let subcategory: String = "Subcategory"
                static let loadoutSlots: String = "Loadout slots:"
            }
            
            enum Sizes {
                static let titleWidth: CGFloat = 150
                static let cellCornerRadius: CGFloat = 12
                static let cellShadowRadius: CGFloat = 5
                static let cellShadowY: CGFloat = 2
                static let cellShadowOpacity: CGFloat = 0.05
                static let dividerPadding: CGFloat = 16
            }
            
            enum Spacing {
                static let zero: CGFloat = 0
                static let content: CGFloat = 16
                static let group: CGFloat = 8
                static let statRow: CGFloat = 12
                static let statRowVertical: CGFloat = 6
                static let cellVertical: CGFloat = 8
                static let groupTop: CGFloat = 8
                static let icon: CGFloat = 8
                static let cellHorizontal: CGFloat = 16
                static let emptyStats: CGFloat = 16
            }
            
            enum Text {
                static let emptyStats: String = "No characteristics available"
            }
            
            enum Fonts {
                static let title: Font = .subheadline
                static let value: Font = .subheadline
                static let header: Font = .headline
                static let icon: Font = .title3
                static let indicator: Font = .caption
            }
            
            enum Format {
                static let double: String = "%.1f"
                static let statTitleSeparator: String = ":"
                static let underscoreReplacement: String = " "
                static let wordSeparator: String = " "
            }
            
            enum Images {
                static let increasing: String = "arrow.up"
                static let decreasing: String = "arrow.down"
            }
        }
        
        // MARK: - Properties
        let itemModel: SearchItemView.ViewModel.FoundedItem.Item
        let selectedType: CellType
        
        // MARK: - Body
        var body: some View {
            content()
        }
    }
}

// MARK: - Main Content
extension Views.DescriptionItemCell {
    @ViewBuilder
    func content() -> some View {
        switch selectedType {
        case .baseInfo:
            baseInfoCell()
        case .fullInfo:
            fullInfoCell()
        case .locations:
            locationsCell()
        case .guides:
            guidesCell()
        }
    }
}

// MARK: - Base Info Cell
extension Views.DescriptionItemCell {
    func baseInfoCell() -> some View {
        baseInfoContent()
            .baseCellStyle()
    }
    
    func baseInfoContent() -> some View {
        VStack(alignment: .leading) {
            statRow(title: Const.Titles.price, value: itemModel.value.description)
            
            if let workbench = itemModel.workbench {
                statRow(title: Const.Titles.workbench, value: workbench)
            }
            if let ammoType = itemModel.ammoType {
                statRow(title: Const.Titles.ammoType, value: ammoType)
            }
            if let shieldType = itemModel.shieldType {
                statRow(title: Const.Titles.shieldType, value: shieldType)
            }
            if let subcategory = itemModel.subcategory {
                statRow(title: Const.Titles.subcategory, value: subcategory)
            }
            if !itemModel.loadoutSlots.isEmpty {
                loadoutSlotsView(slots: itemModel.loadoutSlots)
            }
        }
    }
}

// MARK: - Full Info Cell
extension Views.DescriptionItemCell {
    func fullInfoCell() -> some View {
        VStack(alignment: .leading) {
            if groupedStats.isEmpty {
                emptyStatsView()
            } else {
                statsGroupsView()
            }
        }
    }

    func emptyStatsView() -> some View {
        Text(Const.Text.emptyStats)
            .foregroundColor(.secondary)
            .padding(Const.Spacing.emptyStats)
    }

    func statsGroupsView() -> some View {
        ForEach(groupedStats) { group in
            statGroupView(group: group)
        }
    }

    func statGroupView(group: StatGroup) -> some View {
        VStack(alignment: .leading, spacing: Const.Spacing.group) {
            statGroupHeader(group: group)
            statGroupContent(stats: group.stats)
        }
        .baseCellStyle()
    }

    func statGroupHeader(group: StatGroup) -> some View {
        HStack(spacing: Const.Spacing.icon) {
            Text(group.category.icon)
                .font(Const.Fonts.icon)

            Text(group.category.rawValue)
                .font(Const.Fonts.header)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding(.top, Const.Spacing.groupTop)
    }

    func statGroupContent(stats: [(title: String, value: String)]) -> some View {
        VStack(spacing: Const.Spacing.zero) {
            ForEach(stats, id: \.title) { stat in
                statRow(
                    title: stat.title,
                    value: stat.value,
                    isDeviderNeeded: stat.title != stats.last?.title
                )
                .padding(.vertical, Const.Spacing.statRowVertical)
            }
        }
    }
}

// MARK: - Locations Cell
extension Views.DescriptionItemCell {
    @ViewBuilder
    func locationsCell() -> some View {
        if itemModel.locations.isEmpty {
            emptyLocationsView()
        } else {
            locationsListView()
        }
    }

    func emptyLocationsView() -> some View {
        Text("No locations available")
            .foregroundColor(.secondary)
            .padding(Const.Spacing.emptyStats)
    }

    func locationsListView() -> some View {
        VStack(alignment: .leading, spacing: Const.Spacing.group) {
            ForEach(itemModel.locations, id: \.id) { location in
                locationRow(location: location)
                if location.id != itemModel.locations.last?.id {
                    Divider()
                        .padding(.horizontal, Const.Sizes.dividerPadding)
                }
            }
        }
        .baseCellStyle()
        .padding(.vertical, Const.Spacing.cellVertical)
    }

    func locationRow(location: SearchItemView.ViewModel.FoundedItem.Location) -> some View {
        HStack {
            Image(systemName: "map")
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(location.map)
                .font(Const.Fonts.value)
                .fontWeight(.medium)
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: - Guides Cell
extension Views.DescriptionItemCell {
    @ViewBuilder
    func guidesCell() -> some View {
        if itemModel.guideLinks.isEmpty {
            emptyGuidesView()
        } else {
            guidesListView()
        }
    }

    func emptyGuidesView() -> some View {
        Text("No guides available")
            .foregroundColor(.secondary)
            .padding(Const.Spacing.emptyStats)
    }

    func guidesListView() -> some View {
        VStack(alignment: .leading, spacing: Const.Spacing.group) {
            ForEach(itemModel.guideLinks, id: \.url) { guide in
                guideRow(guide: guide)
                if guide.url != itemModel.guideLinks.last?.url {
                    Divider()
                        .padding(.horizontal, Const.Sizes.dividerPadding)
                }
            }
        }
        .baseCellStyle()
        .padding(.vertical, Const.Spacing.cellVertical)
    }

    func guideRow(guide: SearchItemView.ViewModel.FoundedItem.GuideLink) -> some View {
        Link(destination: URL(string: guide.url) ?? URL(string: "https://google.com")!) {
            HStack {
                Image(systemName: "link")
                    .foregroundColor(.blue)
                    .frame(width: 30)
                Text(guide.label)
                    .font(Const.Fonts.value)
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Stat Row
extension Views.DescriptionItemCell {
    @ViewBuilder
    func statRow(
        title: String,
        value: String,
        isDeviderNeeded: Bool = false
    ) -> some View {
        if !value.isEmpty {
            VStack(spacing: Const.Spacing.zero) {
                statRowContent(title: title, value: value)
            }
        }
    }
    
    func statRowContent(title: String, value: String) -> some View {
        HStack {
            statTitleText(title)
            statValueText(value)
        }
    }
    
    func statTitleText(_ title: String) -> some View {
        Text("\(title)\(Const.Format.statTitleSeparator)")
            .font(Const.Fonts.title)
            .foregroundColor(.secondary)
            .frame(width: Const.Sizes.titleWidth, alignment: .leading)
    }
    
    func statValueText(_ value: String) -> some View {
        Text(value)
            .font(Const.Fonts.value)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Loadout Slots View
extension Views.DescriptionItemCell {
    func loadoutSlotsView(slots: [String]) -> some View {
        HStack(alignment: .firstTextBaseline) {
            loadoutSlotsTitle()
            loadoutSlotsList(slots: slots)
        }
    }
    
    func loadoutSlotsTitle() -> some View {
        Text(Const.Titles.loadoutSlots)
            .font(Const.Fonts.title)
            .foregroundColor(.secondary)
            .frame(width: Const.Sizes.titleWidth, alignment: .leading)
    }
    
    func loadoutSlotsList(slots: [String]) -> some View {
        VStack(alignment: .leading) {
            ForEach(slots, id: \.hashValue) { slot in
                loadoutSlotItem(slot: slot)
            }
        }
    }
    
    func loadoutSlotItem(slot: String) -> some View {
        Text(slot)
            .font(Const.Fonts.value)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Stats Logic
extension Views.DescriptionItemCell {
    var statsFromReflection: [(title: String, value: String)] {
        let mirror = Mirror(reflecting: itemModel.statBlock)
        
        return mirror.children.compactMap { child -> (String, String)? in
            guard let label = child.label else { return nil }
            
            let formattedTitle = formatStatTitle(label)
            
            switch child.value {
            case let value as Int:
                guard value != 0 else { return nil }
                return (formattedTitle, "\(value)")
            case let value as Double:
                guard value != 0.0 else { return nil }
                return (formattedTitle, String(format: Const.Format.double, value))
            case let value as String:
                return value.isEmpty ? nil : (formattedTitle, value)
            default:
                return nil
            }
        }
        .sorted { $0.title < $1.title }
    }
    
    private func formatStatTitle(_ label: String) -> String {
        label
            .replacingOccurrences(of: "_", with: Const.Format.underscoreReplacement)
            .split(separator: Const.Format.wordSeparator)
            .map { $0.capitalized }
            .joined(separator: Const.Format.wordSeparator)
    }
    
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
        .filter { !$0.stats.isEmpty }
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
