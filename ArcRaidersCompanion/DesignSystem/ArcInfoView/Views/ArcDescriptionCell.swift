//
//  ArcDescriptionCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views.ArcInfoView {
    struct ArcDescriptionCell: View {
        private enum Const {
            static let arcFullInfoPadding: CGFloat = 26
            static let imageFrame: CGFloat = 64
            static let fullImageHeightFrame: CGFloat = 180
            static let fullImageWidthFrame: CGFloat = 20
            static let imageViewCornerRadius: CGFloat = 16
            static let overlayCornerRadius: CGFloat = 12
            static let borderWidth: CGFloat = 3
            static let borderWidthDefault: CGFloat = 0
            static let lootString: String = "Loot:"
        }
        
        @State private var isExpanded = false
        var arcModel: Models.ArcModel
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            ArcExpandedCell(isExpanded: $isExpanded, spacing: .none) {
                arcPreviewInfo()
            } content: {
                arcFullInfo()
                    .overlay(
                        RoundedRectangle(cornerRadius: Const.overlayCornerRadius)
                            .stroke( .white, lineWidth: $isExpanded.wrappedValue
                                    ? Const.borderWidth
                                    : Const.borderWidthDefault
                            )
                        )
                    .padding(.bottom, Const.arcFullInfoPadding)
            }
        }
        
        func arcPreviewInfo() -> some View {
            ArcPreviewCell(
                icon: arcModel.icon,
                text: arcModel.name,
                frameWidth: Const.imageFrame,
                frameHeight: Const.imageFrame
            )
        }
        
        func arcFullInfo() -> some View {
            Views.ContainerView {
                VStack {
                    KFImageView(url: URL(string: arcModel.image), cornerRadius: Const.imageViewCornerRadius)
                        .frame(height: Const.fullImageHeightFrame)
                        .frame(maxWidth: Const.fullImageWidthFrame)
                        .padding()
                    Text(arcModel.description)
                        .padding()
                    Text(Const.lootString)
                    Views.ArcInfoView.ArcLootList(lootList: arcModel.loot) { item in
                        // TODO: - Navigation to another scene
                    }
                }
            }
        }
    }
}
