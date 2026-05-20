//
//  ArcsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI
import DesignSystem

struct ArcsView: View {
    private enum Const {
        static let imageFrame: CGFloat = 124
        static let arcTitle: String = "Arcs"
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
        Views.CustomNavigationBar(
            navigationBarStyle: .title(
                .init(
                    title: Const.arcTitle,
                    backAction: {
                        viewModel.navigateBack()
                    }
                )
            )
        )
        ScrollView {
            content()
        }
    }
}

extension ArcsView {
    func content() -> some View {
        LazyVStack {
            arcsTypes()
        }
            .padding(.horizontal)
    }
    
    func arcsTypes() -> some View {
        ForEach(viewModel.arcTypes, id: \.hashValue) { type in
            makeArcListBy(type: type)
        }
    }
    
    func makeArcListBy(type: ViewModel.ArcModel.EnemyType) -> some View {
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
        
        return Views.ExpandedCell(isExpanded: model.0, spacing: .small) {
            arcPreviewCell(type: type)
        } content: {
            LazyVStack {
                ForEach(model.1, id: \.id) { model in
                    arcDescriptionCell(for: model.wrappedValue)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func arcDescriptionCell(for model: ViewModel.ArcModel) -> some View {
        Views.ArcInfoView.ArcDescriptionCell(
            arcModel: .init(
                id: model.id,
                name: model.name,
                description: model.description,
                icon: model.icon,
                image: model.image,
                loot: model.loot
            )
        ) { id in
            viewModel.navigateToSelectedItemScene(with: id)
        }
    }
    
    func arcPreviewCell(type: ViewModel.ArcModel.EnemyType) -> some View {
        Views.ArcInfoView.ArcPreviewCell(
            text: type.rawValue,
            frameWidth: Const.imageFrame,
            frameHeight: Const.imageFrame,
            uiImage: type.image
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
