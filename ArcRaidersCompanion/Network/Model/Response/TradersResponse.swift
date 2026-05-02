//
//  TradersResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Foundation

extension NetworkManager.Model.Response {
    struct TradersResponse: Decodable {
        let data: [NetworkManager.Model.DataModels.TradersData.Trader]
    }
}
