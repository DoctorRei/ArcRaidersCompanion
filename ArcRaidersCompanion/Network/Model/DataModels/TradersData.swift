//
//  TradersData.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension NetworkManager.Model.DataModels.TradersData {
    struct TraderItem: Identifiable, Decodable {
        let id: String
        let icon: String
        let name: String
        let value: Int
        let rarity: String
        let itemType: String
        let description: String
        let traderPrice: Int
    }

    struct Trader: Identifiable, Decodable {
        let id: String
        let name: String
        let items: [TraderItem]
    }
}
