//
//  TradersData.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension NetworkLayer.Model.DataModels.TradersData {
    public struct Trader: Identifiable, Decodable {
        public let id: String
        public let name: String
        public let items: [TraderItem]
    }
    
    public struct TraderItem: Identifiable, Decodable {
        public let id: String
        public let icon: String
        public let name: String
        public let value: Int
        public let rarity: String
        public let itemType: String
        public let description: String
        public let traderPrice: Int
    }
}
