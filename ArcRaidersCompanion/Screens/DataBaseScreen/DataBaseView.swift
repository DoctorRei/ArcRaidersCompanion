//
//  DataBaseView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

struct DataBaseView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Views.DataBaseCollection()
            .task {
                Task {
                    await viewModel.getArcs()
                }
            }
    }
}
