//
//  MetaForgeApi.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import Moya
import Alamofire
import Foundation

enum MetaForgeService {
    case items
    case arcs
    case quests
    case gameAppData
    case events
    case traders
}

// MARK: - TargetType Protocol Implementation
extension MetaForgeService: TargetType {
    var baseURL: URL { URL(string: "https://metaforge.app/api")! }
    var path: String {
        switch self {
        case .items:
            return "arc-raiders/items"
        case .arcs:
            return "arc-raiders/arcs"
        case .quests:
            return "arc-raiders/quests"
        case .gameAppData:
            return "game-map-data"
        case .events:
            return "arc-raiders/events-schedule"
        case .traders:
            return "arc-raiders/traders"
        }
    }
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
