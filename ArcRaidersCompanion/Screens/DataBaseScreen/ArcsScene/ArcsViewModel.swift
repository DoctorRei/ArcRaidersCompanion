//
//  ArcsViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI
import DesignSystem
import NetworkManager
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
        typealias ArcEnemy = NetworkLayer.Model.DataModels.ArcsData.ARCEnemy
        typealias ArcModel = Views.Models.ArcModels.Arc

        weak var coordinator: ArcsCoordinatorProtocol?
        private var networkManager = NetworkLayer.shared
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
            let model = returnArcModel(model: arc)
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
    
    private func returnArcModel(model: ArcEnemy) -> ArcModel {
        return .init(
            id: model.id,
            name: model.name,
            description: model.description,
            icon: model.icon,
            image: model.image,
            loot: model.loot?.map { ArcModel.ArcLoot(id: $0.id, item: returnArcLootItem(for: $0.item), itemId: $0.itemId)} ?? []
        )
    }
    
    private func returnArcLootItem(for model: NetworkLayer.Model.DataModels.ArcsData.LootItem) -> ArcModel.ArcLoot.LootItem {
        .init(
            id: model.id ,
            icon: model.icon,
            name: model.name,
            rarity: .init(rawValue: model.rarity) ?? .common,
            itemType: model.itemType
        )
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
