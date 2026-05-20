//
//  ArcsModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import Foundation

extension NetworkManager.Model.DataModels.ArcsData {
    public struct ARCEnemy: Identifiable, Decodable {
        public let id: String
        let name: String
        let description: String
        let icon: String
        let image: String
        let createdAt: String
        let updatedAt: String
        let loot: [ArcLoot]?
    }
    
    public struct PaginationInfo: Decodable {
        let page: Int
        let limit: Int
        let total: Int
        let totalPages: Int
        let hasNextPage: Bool
        let hasPrevPage: Bool
    }
    
    public struct ArcLoot: Decodable {
        let id: String
        let item: LootItem
        let itemId: String
        let createdAt: String
    }
    
    public struct LootItem: Decodable {
        let id: String
        let icon: String
        let name: String
        let rarity: String
        let itemType: String
    }
}
