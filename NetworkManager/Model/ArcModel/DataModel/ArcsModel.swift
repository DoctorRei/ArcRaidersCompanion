//
//  ArcsModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import Foundation

extension NetworkLayer.Model.DataModels.ArcsData {
    public struct ARCEnemy: Identifiable, Decodable {
        public let id: String
        public let name: String
        public let description: String
        public let icon: String
        public let image: String
        public let createdAt: String
        public let updatedAt: String
        public let loot: [ArcLoot]?
    }
    
    public struct PaginationInfo: Decodable {
        public let page: Int
        public let limit: Int
        public let total: Int
        public let totalPages: Int
        public let hasNextPage: Bool
        public let hasPrevPage: Bool
    }
    
    public struct ArcLoot: Decodable {
        public let id: String
        public let item: LootItem
        public let itemId: String
        public let createdAt: String
    }
    
    public struct LootItem: Decodable {
        public let id: String
        public let icon: String
        public let name: String
        public let rarity: String
        public let itemType: String
    }
}
