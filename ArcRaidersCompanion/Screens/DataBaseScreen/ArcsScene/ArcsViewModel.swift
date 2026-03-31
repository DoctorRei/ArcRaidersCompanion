//
//  ArcsViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI
import Combine

protocol ArcsCoordinatorProtocol: AnyObject {
}

extension ArcsView {
    protocol ViewModelProtocol {
        associatedtype Arcs
        func getArcs() async
    }
    
    final class ViewModel: ObservableObject {
        typealias ArcEnemy = NetworkManager.Model.ARCEnemy
        weak var coordinator: ArcsCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false

        var arcTypes: [ArcEnemy.EnemyType] = [.boss, .ground, .flying, .turret]
        @Published var bossArcs: [ArcEnemy] = []
        @Published var groundArcs: [ArcEnemy] = []
        @Published var flyingArcs: [ArcEnemy] = []
        @Published var turretArcs: [ArcEnemy] = []
    }
}

extension ArcsView.ViewModel: ArcsView.ViewModelProtocol {
    typealias Arcs = NetworkManager.Model.ARCEnemy
    
    func getArcs() async {
        Task {
            do {
                let model = try await networkManager.fetchArcs()
                sortArcsByType(model: model)
            } catch {
                isErrorLoading = true
            }
        }
    }
    
    func sortArcsByType(model: [ArcEnemy]) {
        model.forEach { arc in
            switch arc.type {
            case .ground:
                groundArcs.append(arc)
            case .flying:
                flyingArcs.append(arc)
            case .turret:
                turretArcs.append(arc)
            case .boss:
                bossArcs.append(arc)
            }
        }
    }
}

