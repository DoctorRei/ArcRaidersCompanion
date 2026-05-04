//
//  ItemModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Foundation

// MARK: - Item
extension NetworkManager.Model.DataModels.ItemsData {
    struct Item: Decodable {
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
        let gameAssetId: Int
    }
    
    struct Location: Decodable {
        let id: String
        let map: String
    }
    
    struct ShieldCompatibility: Decodable {
        let value: Int?
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                value = intValue
            } else {
                value = nil
            }
        }
    }

    // MARK: - StatBlock
    struct StatBlock: Decodable {
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
    }

    struct GuideLink: Decodable {
        let url: String
        let label: String
    }

    struct Pagination: Decodable {
        let page: Int
        let limit: Int
        let total: Int
        let totalPages: Int
        let hasNextPage: Bool
        let hasPrevPage: Bool
    }
}
