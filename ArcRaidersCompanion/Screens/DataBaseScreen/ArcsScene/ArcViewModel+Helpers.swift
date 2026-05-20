//
//  ArcViewModel+Helpers.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import UIKit

extension ArcsView.ViewModel.ArcModel {
    enum EnemyType: String, CaseIterable {
        case ground = "Ground"
        case flying = "Flying"
        case turret = "Turret"
        case boss = "Boss"
        
        var image: UIImage {
            switch self {
            case .ground:
                    .ArcTypes.ground
            case .flying:
                    .ArcTypes.flying
            case .turret:
                    .ArcTypes.turret
            case .boss:
                    .ArcTypes.boss
            }
        }
    }
}
