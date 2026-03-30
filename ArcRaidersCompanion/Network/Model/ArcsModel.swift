////
////  ArcsModel.swift
////  ArcRaidersCompanion
////
////  Created by Akira Rei on 30.03.2026.
////
//
//import Foundation
//
//// MARK: - Enhanced ARC Enemy Model with Classification
//struct ARCEnemy: Identifiable, Codable {
//    let id: String
//    let name: String
//    let description: String
//    let icon: String
//    let image: String
//    let createdAt: String
//    let updatedAt: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case description
//        case icon
//        case image
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//    
//    // Определение типа врага на основе ID или имени
//    var type: EnemyType {
//        switch id {
//        case "queen", "matriarch":
//            return .boss
//        case "hornet", "wasp", "snitch", "spotter", "rocketeer", "firefly":
//            return .flying
//        case "turret", "sentinel":
//            return .turret
//        default:
//            return .ground
//        }
//    }
//    
//    // Определение сложности на основе описания и имени
//    var difficulty: EnemyDifficulty {
//        switch id {
//        case "queen", "matriarch":
//            return .elite
//        case "bombardier", "rocketeer", "bison":
//            return .hard
//        case "bastion", "hornet", "shredder":
//            return .medium
//        default:
//            return .easy
//        }
//    }
//    
//    // Краткое описание для карточки
//    var shortDescription: String {
//        let sentences = description.components(separatedBy: ". ")
//        return sentences.first.map { $0 + "." } ?? description
//    }
//    
//    // Основные характеристики из описания
//    var keyFeatures: [String] {
//        var features: [String] = []
//        
//        if description.contains("armor") || description.contains("armored") {
//            features.append("Armored")
//        }
//        if description.contains("rocket") || description.contains("missile") {
//            features.append("Rockets")
//        }
//        if description.contains("laser") || description.contains("beam") {
//            features.append("Lasers")
//        }
//        if description.contains("shield") {
//            features.append("Shield")
//        }
//        if description.contains("explosive") || description.contains("detonate") {
//            features.append("Explosive")
//        }
//        
//        return features
//    }
//}
//
//// MARK: - Enemy Collection
//struct EnemyCollection {
//    let enemies: [ARCEnemy]
//    let pagination: PaginationInfo
//    
//    var allEnemies: [ARCEnemy] { enemies }
//    
//    func enemiesByType(_ type: EnemyType) -> [ARCEnemy] {
//        enemies.filter { $0.type == type }
//    }
//    
//    func enemiesByDifficulty(_ difficulty: EnemyDifficulty) -> [ARCEnemy] {
//        enemies.filter { $0.difficulty == difficulty }
//    }
//    
//    func searchEnemies(query: String) -> [ARCEnemy] {
//        guard !query.isEmpty else { return enemies }
//        return enemies.filter {
//            $0.name.localizedCaseInsensitiveContains(query) ||
//            $0.description.localizedCaseInsensitiveContains(query)
//        }
//    }
//}
//
//// MARK: - JSON Parsing Extension
//extension ARCEnemiesResponse {
//    func toEnemyCollection() -> EnemyCollection {
//        EnemyCollection(enemies: data, pagination: pagination)
//    }
//}
