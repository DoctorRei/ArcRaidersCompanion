//
//  TradersView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

struct TradersView: View {
    private enum Const {
        static let imageFrame: CGFloat = 124
        static let traderTitle: String = "Traders"
    }

    @ObservedObject var viewModel: ViewModel
    @State private var isCellExpanded = false

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        getTradersData()
    }

    var body: some View {
        Views.CustomNavigationBar(
            navigationBarStyle: .title(
                .init(
                    title: Const.traderTitle,
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

extension TradersView {
    func content() -> some View {
        LazyVStack {
            tradersList()
        }
        .padding(.horizontal)
    }

    func tradersList() -> some View {
        ForEach(viewModel.traders, id: \.id) { trader in
            traderDescriptionCell(for: trader)
        }
    }

    func traderDescriptionCell(for trader: ViewModel.TraderModel) -> some View {
        Views.TraderInfoView.TraderDescriptionCell(
            traderModel: trader
        )
    }

    func traderPreviewCell() -> some View {
        Views.TraderInfoView.TraderPreviewCell(
            text: "Eto zabi;",
            frameWidth: Const.imageFrame,
            frameHeight: Const.imageFrame
        )
    }
}

extension TradersView {
    func getTradersData() {
        Task {
            await viewModel.getTraders()
        }
    }
}
