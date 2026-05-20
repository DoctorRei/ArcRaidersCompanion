//
//  ItemModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Foundation

// MARK: - Item
extension NetworkLayer.Model.DataModels.ItemsData {
    public struct Item: Decodable {
        public let id: String
        public let name: String
        public let description: String
        public let itemType: String
        public let loadoutSlots: [String]
        public let icon: String
        public let rarity: String
        public let value: Int
        public let workbench: String?
        public let statBlock: StatBlock
        public let flavorText: String?
        public let subcategory: String?
        public let createdAt: String
        public let updatedAt: String
        public let shieldType: String?
        public let lootArea: String?
        public let sources: String?
        public let ammoType: String?
        public let locations: [Location]
        public let guideLinks: [GuideLink]
        public let gameAssetId: Int?
    }
    
    public struct Location: Decodable {
        public let id: String
        public let map: String
    }
    
    public struct ShieldCompatibility: Decodable {
        public let value: Int?
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                value = intValue
            } else {
                value = nil
            }
        }
    }

    // MARK: - StatBlock
    public struct StatBlock: Decodable {
        public let range: Double?
        public let value: Int?
        public let damage: Double?
        public let health: Int?
        public let radius: Int?
        public let shield: Int?
        public let weight: Double?
        public let agility: Double?
        public let arcStun: Int?
        public let healing: Int?
        public let stamina: Int?
        public let stealth: Int?
        public let useTime: Double?
        public let duration: Int?
        public let fireRate: Double?
        public let stability: Double?
        public let stackSize: Int?
        public let damageMult: Int?
        public let raiderStun: Int?
        public let weightLimit: Int?
        public let augmentSlots: Int?
        public let healingSlots: Int?
        public let magazineSize: Int?
        public let reducedNoise: Int?
        public let shieldCharge: Int?
        public let backpackSlots: Int?
        public let quickUseSlots: Int?
        public let damagePerSecond: Int?
        public let movementPenalty: Int?
        public let safePocketSlots: Int?
        public let damageMitigation: Double?
        public let healingPerSecond: Double?
        public let reducedEquipTime: Int?
        public let staminaPerSecond: Double?
        public let increasedADSSpeed: Int?
        public let increasedFireRate: Int?
        public let reducedReloadTime: Int?
        public let illuminationRadius: Int?
        public let increasedEquipTime: Int?
        public let reducedUnequipTime: Int?
        public let shieldCompatibility: String?
        public let increasedUnequipTime: Int?
        public let reducedVerticalRecoil: Int?
        public let increasedBulletVelocity: Int?
        public let increasedVerticalRecoil: Int?
        public let reducedMaxShotDispersion: Int?
        public let reducedPerShotDispersion: Int?
        public let reducedDurabilityBurnRate: Int?
        public let reducedRecoilRecoveryTime: Int?
        public let increasedRecoilRecoveryTime: Int?
        public let reducedDispersionRecoveryTime: Double?

        public let ammo: String?
        public let firingMode: String?
        public let compatibleWeapons: String?
        public let projectilesPerShot: Int?
        public let reducedProjectileDamage: Int?
    }

    public struct GuideLink: Decodable {
        public let url: String
        public let label: String
    }

    public struct Pagination: Decodable {
        public let page: Int
        public let limit: Int
        public let total: Int
        public let totalPages: Int
        public let hasNextPage: Bool
        public let hasPrevPage: Bool
    }
}
