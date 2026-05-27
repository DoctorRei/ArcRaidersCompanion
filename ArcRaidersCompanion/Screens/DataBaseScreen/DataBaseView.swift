//
//  DataBaseView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI
import DesignSystem

struct DataBaseView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Views.DataBaseCollection { item in
            switch item {
            case .arcs:
                viewModel.showArcsScene()
            case .items:
                viewModel.showSearchItemScene()
            case .traders:
                viewModel.showTradersScene()
            }
        }
    }
}
