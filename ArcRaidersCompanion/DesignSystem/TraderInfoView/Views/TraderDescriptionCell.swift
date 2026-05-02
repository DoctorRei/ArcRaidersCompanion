//
//  TraderDescriptionCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

extension Views.TraderInfoView {
    struct TraderDescriptionCell: View {
        private enum Const {
            static let imageFrame: CGFloat = 64
            static let fullImageHeightFrame: CGFloat = 180
            static let fullImageWidthFrame: CGFloat = 20
            static let imageViewCornerRadius: CGFloat = 16
            static let overlayCornerRadius: CGFloat = 12
            static let borderWidth: CGFloat = 3
            static let borderWidthDefault: CGFloat = 0
        }

        @State private var isExpanded = false
        var traderModel: Views.TraderInfoView.Models.TraderModel

        var body: some View {
            content()
        }

        func content() -> some View {
            Views.ExpandedCell(isExpanded: $isExpanded, spacing: .none) {
                traderPreviewInfo()
            } content: {
                traderFullInfo()
                    .overlay(
                        RoundedRectangle(cornerRadius: Const.overlayCornerRadius)
                            .stroke(.white, lineWidth: $isExpanded.wrappedValue
                                    ? Const.borderWidth
                                    : Const.borderWidthDefault)
                    )
            }
        }

        func traderPreviewInfo() -> some View {
            TraderPreviewCell(
                icon: traderModel.icon,
                text: traderModel.name,
                frameWidth: Const.imageFrame,
                frameHeight: Const.imageFrame
            )
        }

        func traderFullInfo() -> some View {
            Views.ContainerView {
                VStack {
                    KFImageView(url: URL(string: traderModel.image), cornerRadius: Const.imageViewCornerRadius)
                        .frame(height: Const.fullImageHeightFrame)
                        .frame(maxWidth: Const.fullImageWidthFrame)
                        .padding()
                    Text(traderModel.description)
                        .padding()
                }
            }
        }
    }
}
