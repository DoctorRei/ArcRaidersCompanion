//
//  ArcsViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI
import Combine

protocol ArcsCoordinatorProtocol: AnyObject {
    func navigateBack()
    func showItemDetails(id: String)
}

extension ArcsView {
    protocol ViewModelProtocol {
        func getArcs() async
    }
    
    final class ViewModel: ObservableObject {
        typealias ArcEnemy = NetworkManager.Model.DataModels.ArcsData.ARCEnemy
        typealias ArcModel = Views.ArcInfoView.Models.ArcModel

        weak var coordinator: ArcsCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false

        var arcTypes: [ArcModel.EnemyType] = [.boss, .ground, .flying, .turret]
        @Published var bossArcs: [ArcModel] = []
        @Published var groundArcs: [ArcModel] = []
        @Published var flyingArcs: [ArcModel] = []
        @Published var turretArcs: [ArcModel] = []
    }
}

extension ArcsView.ViewModel: ArcsView.ViewModelProtocol {
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
            let model = ArcModel(networkArcModel: arc)
            switch arc.type {
            case .ground:
                groundArcs.append(model)
            case .flying:
                flyingArcs.append(model)
            case .turret:
                turretArcs.append(model)
            case .boss:
                bossArcs.append(model)
            }
        }
    }
}

extension ArcsView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
    
    func navigateToSelectedItemScene(with id: String) {
        coordinator?.showItemDetails(id: id)
    }
}
