//
//  ItemResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Foundation

extension NetworkLayer.Model.Response {
    public struct ItemsResponse: Decodable {
        public let data: [NetworkLayer.Model.DataModels.ItemsData.Item]
        public let maxValue: Int?
        public let pagination: NetworkLayer.Model.DataModels.ItemsData.Pagination?
    }
}
