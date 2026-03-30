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

private extension MetaForgeService {
    enum Const {
        enum Path {
            static let items: String = "arc-raiders/items"
            static let arcs: String = "arc-raiders/arcs"
            static let quests: String = "arc-raiders/quests"
            static let gameAppData: String = "game-map-data"
            static let events: String = "arc-raiders/events-schedule"
            static let traders: String = "arc-raiders/traders"
        }
        static let baseURL: URL = URL(string: "https://metaforge.app/api")!
    }
}

// MARK: - TargetType Protocol Implementation
extension MetaForgeService: TargetType {
    var baseURL: URL { Const.baseURL }
    var path: String {
        switch self {
        case .items:
            return Const.Path.items
        case .arcs:
            return Const.Path.arcs
        case .quests:
            return Const.Path.quests
        case .gameAppData:
            return Const.Path.gameAppData
        case .events:
            return Const.Path.events
        case .traders:
            return Const.Path.traders
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
