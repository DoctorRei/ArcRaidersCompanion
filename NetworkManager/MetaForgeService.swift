//
//  MetaForgeApi.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import Moya
import Alamofire
import Foundation

// MARK: - Sort Fields
public enum SortField: String {
    case name
    case value
    case rarity
    case itemType = "item_type"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    
    var rawValueForAPI: String {
        switch self {
        case .itemType: return "item_type"
        case .createdAt: return "created_at"
        case .updatedAt: return "updated_at"
        default: return self.rawValue
        }
    }
}

public enum SortOrder: String {
    case asc
    case desc
}

public enum ItemType: String, CaseIterable {
    case weapon = "Weapon"
    case armor = "Armor"
    case quickUse = "Quick Use"
    case consumable = "Consumable"
    case modification = "Modification"
    case blueprint = "Blueprint"
    case material = "Material"
    case topsideMaterial = "Topside Material"
    case refinedMaterial = "Refined Material"
    case recyclable = "Recyclable"
    case nature = "Nature"
    case trinket = "Trinket"
    case key = "Key"
    case misc = "Misc"
}

// MARK: - Rarity Types
public enum Rarity: String, CaseIterable {
    case common = "Common"
    case uncommon = "Uncommon"
    case rare = "Rare"
    case epic = "Epic"
    case legendary = "Legendary"
}

// MARK: - Loadout Slots
public enum LoadoutSlot: String, CaseIterable {
    case weapon = "weapon"
    case backpack = "backpack"
    case quickUse = "quickUse"
    case safePocket = "safePocket"
}

enum MetaForgeService {
    case items(page: Int? = nil,
               limit: Int? = nil,
               id: String? = nil,
               itemType: String? = nil,
               rarity: String? = nil,
               search: String? = nil,
               loadoutSlot: String? = nil,
               workbench: String? = nil,
               subcategory: String? = nil,
               shieldType: String? = nil,
               includeComponents: Bool? = nil,
               sortBy: SortField? = nil,
               sortOrder: SortOrder? = nil,
               minimal: Bool? = nil)
    case arcs
    case quests
    case gameAppData
    case events
    case traders
}

private extension MetaForgeService {
    enum Const {
        enum Path {
            static let items: String = "arc-raiders/items"
            static let arcs: String = "arc-raiders/arcs"
            static let quests: String = "arc-raiders/quests"
            static let gameAppData: String = "game-map-data"
            static let events: String = "arc-raiders/events-schedule"
            static let traders: String = "arc-raiders/traders"
        }
        static let baseURL: URL = URL(string: "https://metaforge.app/api")!
    }
}

// MARK: - TargetType Protocol Implementation
extension MetaForgeService: TargetType {
    var baseURL: URL { Const.baseURL }
    var path: String {
        switch self {
        case .items:
            return Const.Path.items
        case .arcs:
            return Const.Path.arcs
        case .quests:
            return Const.Path.quests
        case .gameAppData:
            return Const.Path.gameAppData
        case .events:
            return Const.Path.events
        case .traders:
            return Const.Path.traders
        }
    }
    var method: Moya.Method {
        return .get
    }
    var task: Task {
        switch self {
        case .quests, .gameAppData, .events, .traders:
            return .requestPlain
        case .items(
            let page,
            let limit,
            let id,
            let itemType,
            let rarity,
            let search,
            let loadoutSlot,
            let workbench,
            let subcategory,
            let shieldType,
            let includeComponents,
            let sortBy,
            let sortOrder,
            let minimal
        ):
            var parameters: [String: Any] = [:]
            
            // Пагинация
            if let page = page { parameters["page"] = page }
            if let limit = limit { parameters["limit"] = limit }
            
            // Фильтрация по ID
            if let id = id { parameters["id"] = id }
            
            // Основные фильтры
            if let itemType = itemType { parameters["item_type"] = itemType }
            if let rarity = rarity { parameters["rarity"] = rarity }
            if let search = search { parameters["search"] = search }
            
            // Дополнительные фильтры
            if let loadoutSlot = loadoutSlot { parameters["loadout_slot"] = loadoutSlot }
            if let workbench = workbench { parameters["workbench"] = workbench }
            if let subcategory = subcategory { parameters["subcategory"] = subcategory }
            if let shieldType = shieldType { parameters["shield_type"] = shieldType }
            
            // Опции
            if let includeComponents = includeComponents { parameters["includeComponents"] = includeComponents }
            if let minimal = minimal { parameters["minimal"] = minimal }

            // Сортировка
            if let sortBy = sortBy { parameters["sortBy"] = sortBy.rawValueForAPI }
            if let sortOrder = sortOrder { parameters["sortOrder"] = sortOrder.rawValue }
            
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
        case .arcs:
            return .requestParameters(
                parameters: ["includeLoot": "true"],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
