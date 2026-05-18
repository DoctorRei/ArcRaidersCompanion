//
//  ArcModel+Helpers.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import Foundation

extension NetworkManager.Model.DataModels.ArcsData.ARCEnemy {
    enum EnemyType: String, CaseIterable {
        case ground = "Ground"
        case flying = "Flying"
        case turret = "Turret"
        case boss = "Boss"
        
        var icon: String {
            switch self {
            case .ground: return "figure.walk"
            case .flying: return "paperplane"
            case .turret: return "shield"
            case .boss: return "crown"
            }
        }
    }

    enum EnemyDifficulty: String, CaseIterable {
        case easy = "Easy"
        case medium = "Medium"
        case hard = "Hard"
        case elite = "Elite"
    }
    
    var type: EnemyType {
        switch id {
        case "queen", "matriarch":
            return .boss
        case "hornet", "wasp", "snitch", "spotter", "rocketeer", "firefly", "vaporizer":
            return .flying
        case "turret", "sentinel":
            return .turret
        default:
            return .ground
        }
    }
    
    var difficulty: EnemyDifficulty {
        switch id {
        case "queen", "matriarch":
            return .elite
        case "bombardier", "rocketeer", "bison":
            return .hard
        case "bastion", "hornet", "shredder":
            return .medium
        default:
            return .easy
        }
    }
    
    var shortDescription: String {
        let sentences = description.components(separatedBy: ". ")
        return sentences.first.map { $0 + "." } ?? description
    }

    var keyFeatures: [String] {
        var features: [String] = []
        
        if description.contains("armor") || description.contains("armored") {
            features.append("Armored")
        }
        if description.contains("rocket") || description.contains("missile") {
            features.append("Rockets")
        }
        if description.contains("laser") || description.contains("beam") {
            features.append("Lasers")
        }
        if description.contains("shield") {
            features.append("Shield")
        }
        if description.contains("explosive") || description.contains("detonate") {
            features.append("Explosive")
        }
        
        return features
    }
}

