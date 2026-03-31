//
//  ArcsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI

struct ArcsView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        getArcsData()
        print("TESTTEST Init")
    }

    var body: some View {
        arcsTypes()
            .onAppear {
                print("TESTTEST onApper")
            }
    }
}

extension ArcsView {
    func arcsTypes() -> some View {
        ScrollView {
            ForEach(viewModel.arcTypes, id: \.hashValue) { type in
                switch type {
                case .boss:
                    ForEach($viewModel.bossArcs, id: \.id) { model in
                        arcDescriptionCell(for: model.wrappedValue)
                    }
                case .flying:
                    ForEach($viewModel.flyingArcs, id: \.id) { model in
                        arcDescriptionCell(for: model.wrappedValue)
                    }
                case .ground:
                    ForEach($viewModel.groundArcs, id: \.id) { model in
                        arcDescriptionCell(for: model.wrappedValue)
                    }
                case .turret:
                    ForEach($viewModel.turretArcs, id: \.id) { model in
                        arcDescriptionCell(for: model.wrappedValue)
                    }
                }
            }
        }
    }
    
    func arcDescriptionCell(for model: NetworkManager.Model.ARCEnemy) -> some View {
        Views.ArcDescriptionCell(arcModel: model)
    }
}

extension ArcsView {
    func getArcsData() {
        Task {
            await viewModel.getArcs()
        }
    }
}
