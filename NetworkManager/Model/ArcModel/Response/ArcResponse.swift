//
//  ArcResponse.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import Foundation

extension NetworkManager.Model.Response {
    struct ArcsRespone: Decodable {
        typealias ArcsData = NetworkManager.Model.DataModels.ArcsData

        let data: [ArcsData.ARCEnemy]
        let pagination: ArcsData.PaginationInfo
        let loot: [ArcsData.ArcLoot]?
    }
}
