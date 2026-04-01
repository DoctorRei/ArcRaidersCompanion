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
        Views.DataBaseCollection { item in
            switch item {
            case .arcs:
                viewModel.showArcsScene()
            case .quests:
                print("1")
            case .items:
                print("2")
            case .traders:
                print("3")
            }
        }
    }
}
