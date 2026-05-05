//
//  TraderItemCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

extension Views.TraderInfoView {
    struct TraderItemCell: View {
        private enum Const {
            static let iconFrame: CGFloat = 56
            static let valuePrefix: String = "Value: "
            static let pricePrefix: String = "Trader price: "
        }

        @State private var isFavoriteCell = false
        var itemModel: TradersView.ViewModel.TraderItemModel

        var body: some View {
            content()
                .background(itemModel.rarity.color)
                .cornerRadius(8)
        }

        func content() -> some View {
            HStack(spacing: 12) {
                itemIcon()
                    .frame(width: Const.iconFrame, height: Const.iconFrame)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(itemModel.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Spacer()
                        Views.StarButton(isSelected: $isFavoriteCell) {
                            print("Star Selected")
                        }
                    }

                    Text(itemModel.itemType)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    HStack {
                        Text(Const.valuePrefix + "\(itemModel.value)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Spacer()

                        Text(Const.pricePrefix + "\(itemModel.traderPrice)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .padding(2)
        }

        @ViewBuilder
        func itemIcon() -> some View {
            if let url = URL(string: itemModel.icon) {
                KFImageView(url: url)
            } else {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.gray)
            }
        }
    }
}
