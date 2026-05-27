//
//  DescriptionItemCellViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.04.2026.
//

import Foundation

extension Views.DescriptionItemCell {
    public enum Models {}
}

extension Views.DescriptionItemCell.Models {
    public enum StatCategory: String, CaseIterable {
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
    
    public enum CellType {
        case baseInfo
        case fullInfo
        case locations
        case guides
    }
    
    public struct StatGroup: Identifiable {
        public let id = UUID()
        let category: StatCategory
        let stats: [(title: String, value: String)]
        
        public init(category: StatCategory, stats: [(title: String, value: String)]) {
            self.category = category
            self.stats = stats
        }
    }
}

extension Views.DescriptionItemCell.Models {
    public enum FoundedItem {
        public struct Item: Hashable {
            let id: String
            let name: String
            let description: String
            let itemType: String
            let loadoutSlots: [String]
            let icon: String
            let rarity: String
            let value: Int
            let workbench: String?
            let statBlock: StatBlock
            let flavorText: String?
            let subcategory: String?
            let createdAt: String
            let updatedAt: String
            let shieldType: String?
            let lootArea: String?
            let sources: String?
            let ammoType: String?
            let locations: [Location]
            let guideLinks: [GuideLink]
            let gameAssetId: Int?
            
            public init(id: String, name: String, description: String, itemType: String, loadoutSlots: [String], icon: String, rarity: String, value: Int, workbench: String?, statBlock: StatBlock, flavorText: String?, subcategory: String?, createdAt: String, updatedAt: String, shieldType: String?, lootArea: String?, sources: String?, ammoType: String?, locations: [Location], guideLinks: [GuideLink], gameAssetId: Int?) {
                self.id = id
                self.name = name
                self.description = description
                self.itemType = itemType
                self.loadoutSlots = loadoutSlots
                self.icon = icon
                self.rarity = rarity
                self.value = value
                self.workbench = workbench
                self.statBlock = statBlock
                self.flavorText = flavorText
                self.subcategory = subcategory
                self.createdAt = createdAt
                self.updatedAt = updatedAt
                self.shieldType = shieldType
                self.lootArea = lootArea
                self.sources = sources
                self.ammoType = ammoType
                self.locations = locations
                self.guideLinks = guideLinks
                self.gameAssetId = gameAssetId
            }
            
        // TODO: - Сделать удобный инит для нетворка
//            init(data: NetworkManager.Model.DataModels.ItemsData.Item) {
//                self.id = data.id
//                self.name = data.name
//                self.description = data.description
//                self.itemType = data.itemType
//                self.loadoutSlots = data.loadoutSlots
//                self.icon = data.icon
//                self.rarity = data.rarity
//                self.value = data.value
//                self.workbench = data.workbench
//                self.statBlock = .init(data: data.statBlock)
//                self.flavorText = data.flavorText
//                self.subcategory = data.subcategory
//                self.createdAt = data.createdAt
//                self.updatedAt = data.updatedAt
//                self.shieldType = data.shieldType
//                self.lootArea = data.lootArea
//                self.sources = data.sources
//                self.ammoType = data.ammoType
//                self.locations = data.locations.map { .init(data: $0)}
//                self.guideLinks = data.guideLinks.map { .init(data: $0)}
//                self.gameAssetId = data.gameAssetId
//            }
        }
        
        public struct Location: Hashable {
            let id: String
            let map: String
            
            public init(id: String, map: String) {
                self.id = id
                self.map = map
            }
            
            // TODO: - Сделать удобный инит для нетворка
//            init(data: NetworkManager.Model.DataModels.ItemsData.Location) {
//                self.id = data.id
//                self.map = data.map
//            }
        }
        
        // MARK: - StatBlock
        public struct StatBlock: Hashable {
            let range: Double?
            let value: Int?
            let damage: Double?
            let health: Int?
            let radius: Int?
            let shield: Int?
            let weight: Double?
            let agility: Double?
            let arcStun: Int?
            let healing: Int?
            let stamina: Int?
            let stealth: Int?
            let useTime: Double?
            let duration: Int?
            let fireRate: Double?
            let stability: Double?
            let stackSize: Int?
            let damageMult: Int?
            let raiderStun: Int?
            let weightLimit: Int?
            let augmentSlots: Int?
            let healingSlots: Int?
            let magazineSize: Int?
            let reducedNoise: Int?
            let shieldCharge: Int?
            let backpackSlots: Int?
            let quickUseSlots: Int?
            let damagePerSecond: Int?
            let movementPenalty: Int?
            let safePocketSlots: Int?
            let damageMitigation: Double?
            let healingPerSecond: Double?
            let reducedEquipTime: Int?
            let staminaPerSecond: Double?
            let increasedADSSpeed: Int?
            let increasedFireRate: Int?
            let reducedReloadTime: Int?
            let illuminationRadius: Int?
            let increasedEquipTime: Int?
            let reducedUnequipTime: Int?
            let shieldCompatibility: String?
            let increasedUnequipTime: Int?
            let reducedVerticalRecoil: Int?
            let increasedBulletVelocity: Int?
            let increasedVerticalRecoil: Int?
            let reducedMaxShotDispersion: Int?
            let reducedPerShotDispersion: Int?
            let reducedDurabilityBurnRate: Int?
            let reducedRecoilRecoveryTime: Int?
            let increasedRecoilRecoveryTime: Int?
            let reducedDispersionRecoveryTime: Double?
            
            let ammo: String?
            let firingMode: String?
            let compatibleWeapons: String?
            let projectilesPerShot: Int?
            let reducedProjectileDamage: Int?
            
            public init(
                range: Double?,
                value: Int?,
                damage: Double?,
                health: Int?,
                radius: Int?,
                shield: Int?,
                weight: Double?,
                agility: Double?,
                arcStun: Int?,
                healing: Int?,
                stamina: Int?,
                stealth: Int?,
                useTime: Double?,
                duration: Int?,
                fireRate: Double?,
                stability: Double?,
                stackSize: Int?,
                damageMult: Int?,
                raiderStun: Int?,
                weightLimit: Int?,
                augmentSlots: Int?,
                healingSlots: Int?,
                magazineSize: Int?,
                reducedNoise: Int?,
                shieldCharge: Int?,
                backpackSlots: Int?,
                quickUseSlots: Int?,
                damagePerSecond: Int?,
                movementPenalty: Int?,
                safePocketSlots: Int?,
                damageMitigation: Double?,
                healingPerSecond: Double?,
                reducedEquipTime: Int?,
                staminaPerSecond: Double?,
                increasedADSSpeed: Int?,
                increasedFireRate: Int?,
                reducedReloadTime: Int?,
                illuminationRadius: Int?,
                increasedEquipTime: Int?,
                reducedUnequipTime: Int?,
                shieldCompatibility: String?,
                increasedUnequipTime: Int?,
                reducedVerticalRecoil: Int?,
                increasedBulletVelocity: Int?,
                increasedVerticalRecoil: Int?,
                reducedMaxShotDispersion: Int?,
                reducedPerShotDispersion: Int?,
                reducedDurabilityBurnRate: Int?,
                reducedRecoilRecoveryTime: Int?,
                increasedRecoilRecoveryTime: Int?,
                reducedDispersionRecoveryTime: Double?,
                ammo: String?,
                firingMode: String?,
                compatibleWeapons: String?,
                projectilesPerShot: Int?,
                reducedProjectileDamage: Int?
            ) {
                self.range = range
                self.value = value
                self.damage = damage
                self.health = health
                self.radius = radius
                self.shield = shield
                self.weight = weight
                self.agility = agility
                self.arcStun = arcStun
                self.healing = healing
                self.stamina = stamina
                self.stealth = stealth
                self.useTime = useTime
                self.duration = duration
                self.fireRate = fireRate
                self.stability = stability
                self.stackSize = stackSize
                self.damageMult = damageMult
                self.raiderStun = raiderStun
                self.weightLimit = weightLimit
                self.augmentSlots = augmentSlots
                self.healingSlots = healingSlots
                self.magazineSize = magazineSize
                self.reducedNoise = reducedNoise
                self.shieldCharge = shieldCharge
                self.backpackSlots = backpackSlots
                self.quickUseSlots = quickUseSlots
                self.damagePerSecond = damagePerSecond
                self.movementPenalty = movementPenalty
                self.safePocketSlots = safePocketSlots
                self.damageMitigation = damageMitigation
                self.healingPerSecond = healingPerSecond
                self.reducedEquipTime = reducedEquipTime
                self.staminaPerSecond = staminaPerSecond
                self.increasedADSSpeed = increasedADSSpeed
                self.increasedFireRate = increasedFireRate
                self.reducedReloadTime = reducedReloadTime
                self.illuminationRadius = illuminationRadius
                self.increasedEquipTime = increasedEquipTime
                self.reducedUnequipTime = reducedUnequipTime
                self.shieldCompatibility = shieldCompatibility
                self.increasedUnequipTime = increasedUnequipTime
                self.reducedVerticalRecoil = reducedVerticalRecoil
                self.increasedBulletVelocity = increasedBulletVelocity
                self.increasedVerticalRecoil = increasedVerticalRecoil
                self.reducedMaxShotDispersion = reducedMaxShotDispersion
                self.reducedPerShotDispersion = reducedPerShotDispersion
                self.reducedDurabilityBurnRate = reducedDurabilityBurnRate
                self.reducedRecoilRecoveryTime = reducedRecoilRecoveryTime
                self.increasedRecoilRecoveryTime = increasedRecoilRecoveryTime
                self.reducedDispersionRecoveryTime = reducedDispersionRecoveryTime
                self.ammo = ammo
                self.firingMode = firingMode
                self.compatibleWeapons = compatibleWeapons
                self.projectilesPerShot = projectilesPerShot
                self.reducedProjectileDamage = reducedProjectileDamage
            }
            
            // TODO: - Сделать удобный инит для нетворка
//            init(data: NetworkManager.Model.DataModels.ItemsData.StatBlock) {
//                self.range = data.range
//                self.value = data.value
//                self.damage = data.damage
//                self.health = data.health
//                self.radius = data.radius
//                self.shield = data.shield
//                self.weight = data.weight
//                self.agility = data.agility
//                self.arcStun = data.arcStun
//                self.healing = data.healing
//                self.stamina = data.stamina
//                self.stealth = data.stealth
//                self.useTime = data.useTime
//                self.duration = data.duration
//                self.fireRate = data.fireRate
//                self.stability = data.stability
//                self.stackSize = data.stackSize
//                self.damageMult = data.damageMult
//                self.raiderStun = data.raiderStun
//                self.weightLimit = data.weightLimit
//                self.augmentSlots = data.augmentSlots
//                self.healingSlots = data.healingSlots
//                self.magazineSize = data.magazineSize
//                self.reducedNoise = data.reducedNoise
//                self.shieldCharge = data.shieldCharge
//                self.backpackSlots = data.backpackSlots
//                self.quickUseSlots = data.quickUseSlots
//                self.damagePerSecond = data.damagePerSecond
//                self.movementPenalty = data.movementPenalty
//                self.safePocketSlots = data.safePocketSlots
//                self.damageMitigation = data.damageMitigation
//                self.healingPerSecond = data.healingPerSecond
//                self.reducedEquipTime = data.reducedEquipTime
//                self.staminaPerSecond = data.staminaPerSecond
//                self.increasedADSSpeed = data.increasedADSSpeed
//                self.increasedFireRate = data.increasedFireRate
//                self.reducedReloadTime = data.reducedReloadTime
//                self.illuminationRadius = data.illuminationRadius
//                self.increasedEquipTime = data.increasedEquipTime
//                self.reducedUnequipTime = data.reducedUnequipTime
//                self.shieldCompatibility = data.shieldCompatibility /*data.shieldCompatibility.flatMap { $0.value }*/
//                self.increasedUnequipTime = data.increasedUnequipTime
//                self.reducedVerticalRecoil = data.reducedVerticalRecoil
//                self.increasedBulletVelocity = data.increasedBulletVelocity
//                self.increasedVerticalRecoil = data.increasedVerticalRecoil
//                self.reducedMaxShotDispersion = data.reducedMaxShotDispersion
//                self.reducedPerShotDispersion = data.reducedPerShotDispersion
//                self.reducedDurabilityBurnRate = data.reducedDurabilityBurnRate
//                self.reducedRecoilRecoveryTime = data.reducedRecoilRecoveryTime
//                self.increasedRecoilRecoveryTime = data.increasedRecoilRecoveryTime
//                self.reducedDispersionRecoveryTime = data.reducedDispersionRecoveryTime
//                
//                self.ammo = data.ammo
//                self.firingMode = data.firingMode
//                self.compatibleWeapons = data.compatibleWeapons
//                self.projectilesPerShot = data.projectilesPerShot
//                self.reducedProjectileDamage = data.reducedProjectileDamage
//            }
        }
        
        public struct GuideLink: Hashable {
            let url: String
            let label: String
            
            public init(url: String, label: String) {
                self.url = url
                self.label = label
            }
            
            // TODO: - Сделать удобный инит для нетворка
//            init(data: NetworkManager.Model.DataModels.ItemsData.GuideLink) {
//                self.url = data.url
//                self.label = data.label
//            }
        }
        
        public struct Pagination: Hashable {
            let page: Int
            let limit: Int
            let total: Int
            let totalPages: Int
            let hasNextPage: Bool
            let hasPrevPage: Bool
            
            // TODO: - Сделать удобный инит для нетворка
//            init(data: NetworkManager.Model.DataModels.ItemsData.Pagination) {
//                self.page = data.page
//                self.limit = data.limit
//                self.total = data.total
//                self.totalPages = data.totalPages
//                self.hasNextPage = data.hasNextPage
//                self.hasPrevPage = data.hasPrevPage
//            }
        }
    }
}
