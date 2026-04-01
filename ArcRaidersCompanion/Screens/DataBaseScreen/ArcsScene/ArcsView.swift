//
//  ArcsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI

struct ArcsView: View {
    private enum Const {
        static let imageFrame: CGFloat = 124
    }
    
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
            makeArcListBy(type: type)
        }
    }
    
    func makeArcListBy(type: ViewModel.ArcEnemy.EnemyType) -> some View {
        let model = switch type {
        case .boss:
            ($isCellBossExpanded, $viewModel.bossArcs)
        case .ground:
            ($isCellGroundExpanded, $viewModel.groundArcs)
        case .flying:
            ($isCellFlyingExpanded, $viewModel.flyingArcs)
        case .turret:
            ($isCellTurretExpanded, $viewModel.turretArcs)
        }
        
        return Views.ArcExpandedCell(isExpanded: model.0, spacing: .small) {
            arcPreviewCell(type: type)
        } content: {
                ForEach(model.1, id: \.id) { model in
                    arcDescriptionCell(for: model.wrappedValue)
                }
            .padding(.horizontal)
        }
    }
    
    func arcDescriptionCell(for model: NetworkManager.Model.ARCEnemy) -> some View {
        Views.ArcDescriptionCell(arcModel: model)
    }
    
    func arcPreviewCell(type: ViewModel.ArcEnemy.EnemyType) -> some View {
        Views.ArcPreviewCell(
            text: type.rawValue,
            frameWidth: Const.imageFrame,
            frameHeight: Const.imageFrame
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
