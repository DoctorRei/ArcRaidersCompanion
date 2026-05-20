//
//  TradersResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension NetworkLayer.Model.Response {
    struct TradersResponse: Decodable {
        let success: Bool
        let data: [String: [NetworkLayer.Model.DataModels.TradersData.TraderItem]]
    }
}
