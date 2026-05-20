//
//  ArcResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import Foundation

extension NetworkLayer.Model.Response {
    struct ArcsRespone: Decodable {
        typealias ArcsData = NetworkLayer.Model.DataModels.ArcsData

        let data: [ArcsData.ARCEnemy]
        let pagination: ArcsData.PaginationInfo
        let loot: [ArcsData.ArcLoot]?
    }
}
