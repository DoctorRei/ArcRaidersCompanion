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
            static let iconFrame: CGFloat = 40
            static let valuePrefix: String = "Value: "
            static let pricePrefix: String = "Trader price: "
        }

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
                    Text(itemModel.name)
                        .font(.headline)
                        .foregroundColor(.primary)

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
                            .foregroundColor(.blue)
                    }

                    Text(itemModel.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }

                Spacer()
            }
            .padding(.vertical, 4)
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
