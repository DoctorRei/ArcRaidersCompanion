//
//  ItemResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Foundation

extension NetworkManager.Model.Response {
    struct ItemsResponse: Decodable {
        let data: [NetworkManager.Model.DataModels.ItemsData.Item]
        let maxValue: Int?
        let pagination: NetworkManager.Model.DataModels.ItemsData.Pagination?
    }
}
