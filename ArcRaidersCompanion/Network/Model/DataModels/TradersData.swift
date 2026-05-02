//
//  TradersData.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension NetworkManager.Model.DataModels.TradersData {
    struct Trader: Identifiable, Decodable {
        let id: String
        let name: String
        let description: String
        let icon: String
        let image: String
    }
}
