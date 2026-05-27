//
//  SearchItemViewModel+Extension.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.04.2026.
//

import Foundation
import NetworkManager

// TODO: - Проверить где юзается и почему не ругалось раньше

extension SearchItemView.ViewModel {
    enum FoundedItem {
        struct Item: Hashable {
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
            
            init(data: NetworkLayer.Model.DataModels.ItemsData.Item) {
                self.id = data.id
                self.name = data.name
                self.description = data.description
                self.itemType = data.itemType
                self.loadoutSlots = data.loadoutSlots
                self.icon = data.icon
                self.rarity = data.rarity
                self.value = data.value
                self.workbench = data.workbench
                self.statBlock = .init(data: data.statBlock)
                self.flavorText = data.flavorText
                self.subcategory = data.subcategory
                self.createdAt = data.createdAt
                self.updatedAt = data.updatedAt
                self.shieldType = data.shieldType
                self.lootArea = data.lootArea
                self.sources = data.sources
                self.ammoType = data.ammoType
                self.locations = data.locations.map { .init(data: $0)}
                self.guideLinks = data.guideLinks.map { .init(data: $0)}
                self.gameAssetId = data.gameAssetId
            }
        }
        
        struct Location: Hashable {
            let id: String
            let map: String
            
            init(data: NetworkLayer.Model.DataModels.ItemsData.Location) {
                self.id = data.id
                self.map = data.map
            }
        }
        
        // MARK: - StatBlock
        struct StatBlock: Hashable {
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
            
            init(data: NetworkLayer.Model.DataModels.ItemsData.StatBlock) {
                self.range = data.range
                self.value = data.value
                self.damage = data.damage
                self.health = data.health
                self.radius = data.radius
                self.shield = data.shield
                self.weight = data.weight
                self.agility = data.agility
                self.arcStun = data.arcStun
                self.healing = data.healing
                self.stamina = data.stamina
                self.stealth = data.stealth
                self.useTime = data.useTime
                self.duration = data.duration
                self.fireRate = data.fireRate
                self.stability = data.stability
                self.stackSize = data.stackSize
                self.damageMult = data.damageMult
                self.raiderStun = data.raiderStun
                self.weightLimit = data.weightLimit
                self.augmentSlots = data.augmentSlots
                self.healingSlots = data.healingSlots
                self.magazineSize = data.magazineSize
                self.reducedNoise = data.reducedNoise
                self.shieldCharge = data.shieldCharge
                self.backpackSlots = data.backpackSlots
                self.quickUseSlots = data.quickUseSlots
                self.damagePerSecond = data.damagePerSecond
                self.movementPenalty = data.movementPenalty
                self.safePocketSlots = data.safePocketSlots
                self.damageMitigation = data.damageMitigation
                self.healingPerSecond = data.healingPerSecond
                self.reducedEquipTime = data.reducedEquipTime
                self.staminaPerSecond = data.staminaPerSecond
                self.increasedADSSpeed = data.increasedADSSpeed
                self.increasedFireRate = data.increasedFireRate
                self.reducedReloadTime = data.reducedReloadTime
                self.illuminationRadius = data.illuminationRadius
                self.increasedEquipTime = data.increasedEquipTime
                self.reducedUnequipTime = data.reducedUnequipTime
                self.shieldCompatibility = data.shieldCompatibility /*data.shieldCompatibility.flatMap { $0.value }*/
                self.increasedUnequipTime = data.increasedUnequipTime
                self.reducedVerticalRecoil = data.reducedVerticalRecoil
                self.increasedBulletVelocity = data.increasedBulletVelocity
                self.increasedVerticalRecoil = data.increasedVerticalRecoil
                self.reducedMaxShotDispersion = data.reducedMaxShotDispersion
                self.reducedPerShotDispersion = data.reducedPerShotDispersion
                self.reducedDurabilityBurnRate = data.reducedDurabilityBurnRate
                self.reducedRecoilRecoveryTime = data.reducedRecoilRecoveryTime
                self.increasedRecoilRecoveryTime = data.increasedRecoilRecoveryTime
                self.reducedDispersionRecoveryTime = data.reducedDispersionRecoveryTime
                
                self.ammo = data.ammo
                self.firingMode = data.firingMode
                self.compatibleWeapons = data.compatibleWeapons
                self.projectilesPerShot = data.projectilesPerShot
                self.reducedProjectileDamage = data.reducedProjectileDamage
            }
        }
        
        struct GuideLink: Hashable {
            let url: String
            let label: String
            
            init(data: NetworkLayer.Model.DataModels.ItemsData.GuideLink) {
                self.url = data.url
                self.label = data.label
            }
        }
        
        struct Pagination: Hashable {
            let page: Int
            let limit: Int
            let total: Int
            let totalPages: Int
            let hasNextPage: Bool
            let hasPrevPage: Bool
            
            init(data: NetworkLayer.Model.DataModels.ItemsData.Pagination) {
                self.page = data.page
                self.limit = data.limit
                self.total = data.total
                self.totalPages = data.totalPages
                self.hasNextPage = data.hasNextPage
                self.hasPrevPage = data.hasPrevPage
            }
        }
    }
}
