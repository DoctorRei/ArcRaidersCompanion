//
//  ArcsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI

struct ArcsView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isCellBossExpanded = false
    @State private var isCellFlyingExpanded = false
    @State private var isCellGroundExpanded = false
    @State private var isCellTurretExpanded = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        getArcsData()
    }
    
    var body: some View {
        ScrollView {
            content()
        }
    }
}

extension ArcsView {
    func content() -> some View {
        arcsTypes()
            .padding(.horizontal)
    }
    
    func arcsTypes() -> some View {
        ForEach(viewModel.arcTypes, id: \.hashValue) { type in
            switch type {
            case .boss:
                Views.ArcExpandedCell(isExpanded: $isCellBossExpanded) {
                    arcPreviewCell(type: type)
                } content: {
                    VStack(spacing: 2) {
                        ForEach($viewModel.bossArcs, id: \.id) { model in
                            arcDescriptionCell(for: model.wrappedValue)
                        }
                    }
                    .padding(.horizontal)
                }
            case .flying:
                Views.ArcExpandedCell(isExpanded: $isCellFlyingExpanded) {
                    arcPreviewCell(type: type)
                } content: {
                    VStack(spacing: 2) {
                        ForEach($viewModel.flyingArcs, id: \.id) { model in
                            arcDescriptionCell(for: model.wrappedValue)
                        }
                    }
                    .padding(.horizontal)
                }
            case .ground:
                Views.ArcExpandedCell(isExpanded: $isCellGroundExpanded) {
                    arcPreviewCell(type: type)
                } content: {
                    VStack(spacing: 2) {
                        ForEach($viewModel.groundArcs, id: \.id) { model in
                            arcDescriptionCell(for: model.wrappedValue)
                        }
                    }
                    .padding(.horizontal)
                }
            case .turret:
                Views.ArcExpandedCell(isExpanded: $isCellTurretExpanded) {
                    arcPreviewCell(type: type)
                } content: {
                    VStack(spacing: 2) {
                        ForEach($viewModel.turretArcs, id: \.id) { model in
                            arcDescriptionCell(for: model.wrappedValue)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    func arcDescriptionCell(for model: NetworkManager.Model.ARCEnemy) -> some View {
        Views.ArcDescriptionCell(arcModel: model)
    }
    
    func arcPreviewCell(type: ArcsView.ViewModel.ArcEnemy.EnemyType) -> some View {
        Views.ArcPreviewCell(
            text: type.rawValue,
            frameWidth: 124,
            frameHeight: 124
        )
    }
}

extension ArcsView {
    func getArcsData() {
        Task {
            await viewModel.getArcs()
        }
    }
}
