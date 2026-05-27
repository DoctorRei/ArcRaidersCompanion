//
//  TradersView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI
import DesignSystem

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
        .onAppear() {
            viewModel.updateFavoriteItems()
        }
    }
}

private extension TradersView {
    func content() -> some View {
        LazyVStack {
            ForEach(viewModel.traders, id: \.stableId) { trader in
                traderCell(for: trader)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func traderCell(for trader: ViewModel.TraderModel) -> some View {
        Views.ContainerView {
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    openCellFor(id: trader.id)
                } label: {
                    traderPreviewCell(trader: trader)
                }
                .buttonStyle(.plain)

                if expandedTraderId == trader.id {
                    traderItemsList(items: trader.items)
                        .transition(.opacity)
                }
            }
        }
        .overlay {
            overlayForCell(trader: trader.id)
        }
    }
    
    @ViewBuilder
    func overlayForCell(trader id: String) -> some View {
        if expandedTraderId == id {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 3)
        }
    }

    func traderPreviewCell(trader: ViewModel.TraderModel) -> some View {
            Views.TraderInfoView.TraderPreviewCell(
                text: trader.name,
                frameWidth: Const.imageFrame,
                frameHeight: Const.imageFrame
            )
            .frame(maxWidth: .infinity)
            .overlay {
                overlayForCell(trader: trader.id)
            }
    }

    func traderItemsList(items: [ViewModel.TraderItemModel]) -> some View {
        LazyVStack(spacing: 2) {
            ForEach(items) { item in
                Views.TraderInfoView.TraderItemCell(itemModel: viewModel.returnTraderModel(for: item)) { itemModel in
                    viewModel.favoriteButtonPressed(
                        for: .init(
                            id: itemModel.id,
                            name: itemModel.name,
                            icon: itemModel.icon,
                            isSelected: itemModel.isSelected
                        )
                    )
                }
                .onTapGesture {
                    viewModel.showItemDetails(id: item.id)
                }
            }
        }
        .padding(6)
    }
}

private extension TradersView {
    func getTradersData() {
        Task {
            await viewModel.getTraders()
        }
    }
    
    func openCellFor(id: String) {
        withAnimation {
            if expandedTraderId == id {
                expandedTraderId = nil
            } else {
                expandedTraderId = id
            }
        }
    }
}
