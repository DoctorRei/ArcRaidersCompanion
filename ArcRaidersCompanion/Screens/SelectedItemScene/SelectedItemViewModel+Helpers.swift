//
//  SelectedItemViewModel+Helpers.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 20.05.2026.
//

import DesignSystem

extension SelectedItemView.ViewModel {
    typealias FoundedItem = Views.DescriptionItemCell.Models.FoundedItem
    func returnItemModel(from model: SearchItemView.ViewModel.FoundedItem.Item) -> FoundedItem.Item {
        .init(
            id: model.id,
            name: model.name,
            description: model.description,
            itemType: model.itemType,
            loadoutSlots: model.loadoutSlots,
            icon: model.icon,
            rarity: model.rarity,
            value: model.value,
            workbench: model.workbench,
            statBlock: returnStatBlockModel(from: model.statBlock),
            flavorText: model.flavorText,
            subcategory: model.subcategory,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
            shieldType: model.shieldType,
            lootArea: model.lootArea,
            sources: model.sources,
            ammoType: model.ammoType,
            locations: model.locations.map { returnLocationsModel(from: $0) },
            guideLinks: model.guideLinks.map { returnGuideLinks(from: $0) },
            gameAssetId: model.gameAssetId
        )
    }
    
    func returnStatBlockModel(from model: SearchItemView.ViewModel.FoundedItem.StatBlock) -> FoundedItem.StatBlock {
        .init(
            range: model.range,
            value: model.value,
            damage: model.damage,
            health: model.health,
            radius: model.radius,
            shield: model.shield,
            weight: model.weight,
            agility: model.agility,
            arcStun: model.arcStun,
            healing: model.healing,
            stamina: model.stamina,
            stealth: model.stealth,
            useTime: model.useTime,
            duration: model.duration,
            fireRate: model.fireRate,
            stability: model.stability,
            stackSize: model.stackSize,
            damageMult: model.damageMult,
            raiderStun: model.raiderStun,
            weightLimit: model.weightLimit,
            augmentSlots: model.augmentSlots,
            healingSlots: model.healingSlots,
            magazineSize: model.magazineSize,
            reducedNoise: model.reducedNoise,
            shieldCharge: model.shieldCharge,
            backpackSlots: model.backpackSlots,
            quickUseSlots: model.quickUseSlots,
            damagePerSecond: model.damagePerSecond,
            movementPenalty: model.movementPenalty,
            safePocketSlots: model.safePocketSlots,
            damageMitigation: model.damageMitigation,
            healingPerSecond: model.healingPerSecond,
            reducedEquipTime: model.reducedEquipTime,
            staminaPerSecond: model.staminaPerSecond,
            increasedADSSpeed: model.increasedADSSpeed,
            increasedFireRate: model.increasedFireRate,
            reducedReloadTime: model.reducedReloadTime,
            illuminationRadius: model.illuminationRadius,
            increasedEquipTime: model.increasedEquipTime,
            reducedUnequipTime: model.reducedUnequipTime,
            shieldCompatibility: model.shieldCompatibility,
            increasedUnequipTime: model.increasedUnequipTime,
            reducedVerticalRecoil: model.reducedVerticalRecoil,
            increasedBulletVelocity: model.increasedBulletVelocity,
            increasedVerticalRecoil: model.increasedVerticalRecoil,
            reducedMaxShotDispersion: model.reducedMaxShotDispersion,
            reducedPerShotDispersion: model.reducedPerShotDispersion,
            reducedDurabilityBurnRate: model.reducedDurabilityBurnRate,
            reducedRecoilRecoveryTime: model.reducedRecoilRecoveryTime,
            increasedRecoilRecoveryTime: model.increasedRecoilRecoveryTime,
            reducedDispersionRecoveryTime: model.reducedDispersionRecoveryTime,
            ammo: model.ammo,
            firingMode: model.firingMode,
            compatibleWeapons: model.compatibleWeapons,
            projectilesPerShot: model.projectilesPerShot,
            reducedProjectileDamage: model.reducedProjectileDamage
        )
    }
    
    func returnLocationsModel(from model: SearchItemView.ViewModel.FoundedItem.Location) -> FoundedItem.Location {
        .init(id: model.id, map: model.map)
    }
    
    func returnGuideLinks(from model: SearchItemView.ViewModel.FoundedItem.GuideLink) -> FoundedItem.GuideLink {
        .init(url: model.url, label: model.label)
    }
}
