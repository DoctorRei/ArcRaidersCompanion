//
//  TradersView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

struct TradersView: View {
    private enum Const {
        static let traderTitle: String = "Traders"
        static let imageFrame: CGFloat = 64
    }

    @ObservedObject var viewModel: ViewModel
    @State private var expandedTraderId: String?

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
            ForEach(viewModel.traders) { trader in
                traderCell(for: trader)
            }
        }
        .padding(.horizontal)
    }

    func traderCell(for trader: ViewModel.TraderModel) -> some View {
        Views.ContainerView {
            VStack(alignment: .leading, spacing: 8) {
                Button(action: {
                    withAnimation {
                        if expandedTraderId == trader.id {
                            expandedTraderId = nil
                        } else {
                            expandedTraderId = trader.id
                        }
                    }
                }) {
                    traderPreviewCell(trader: trader)
                }
                .buttonStyle(PlainButtonStyle())

                if expandedTraderId == trader.id {
                    traderItemsList(items: trader.items)
                        .transition(.opacity)
                }
            }
        }
    }

    func traderPreviewCell(trader: ViewModel.TraderModel) -> some View {
        HStack {
            Views.TraderInfoView.TraderPreviewCell(
                text: trader.name,
                frameWidth: Const.imageFrame,
                frameHeight: Const.imageFrame
            )
            Spacer()
            Image(systemName: expandedTraderId == trader.id ? "chevron.up" : "chevron.down")
                .foregroundColor(.secondary)
        }
    }

    func traderItemsList(items: [TradersView.TraderItemModel]) -> some View {
        VStack {
            ForEach(items) { item in
                Views.TraderInfoView.TraderItemCell(itemModel: item)
                if item.id != items.last?.id {
                    Divider()
                }
            }
        }
        .padding(.horizontal)
    }
}

extension TradersView {
    func getTradersData() {
        Task {
            await viewModel.getTraders()
        }
    }
}
