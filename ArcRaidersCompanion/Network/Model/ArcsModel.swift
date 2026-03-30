//
//  ArcsModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import Foundation

// MARK: - Enhanced ARC Enemy Model with Classification
extension NetworkManager.Model {
    struct ARCEnemy: Identifiable, Decodable {
        let id: String
        let name: String
        let description: String
        let icon: String
        let image: String
        let createdAt: String
        let updatedAt: String
    }
    
    struct PaginationInfo: Decodable {
        let page: Int
        let limit: Int
        let total: Int
        let totalPages: Int
        let hasNextPage: Bool
        let hasPrevPage: Bool
    }
    
    // MARK: - Enemy Collection
    struct ArcsRespone: Decodable {
        let data: [ARCEnemy]
        let pagination: PaginationInfo
    }
}

extension NetworkManager.Model.ARCEnemy {
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
        case "hornet", "wasp", "snitch", "spotter", "rocketeer", "firefly":
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

//// MARK: - JSON Parsing Extension
//extension ARCEnemiesResponse {
//    func toEnemyCollection() -> EnemyCollection {
//        EnemyCollection(enemies: data, pagination: pagination)
//    }
//}
