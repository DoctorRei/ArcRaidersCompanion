//
//  ArcDescriptionCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views {
    struct ArcDescriptionCell: View {
        private enum Const {
            static let arcFullInfoPadding: CGFloat = 26
            static let imageFrame: CGFloat = 64
            static let fullImageHeightFrame: CGFloat = 200
            static let fullImageWidthFrame: CGFloat = 250
            static let imageViewCornerRadius: CGFloat = 16
        }
        
        @State private var isExpanded = false
        var arcModel: NetworkManager.Model.ARCEnemy
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            ArcExpandedCell(isExpanded: $isExpanded, spacing: .none) {
                arcPreviewInfo()
            } content: {
                arcFullInfo()
                    .padding(.bottom, Const.arcFullInfoPadding)
            }
        }
        
        func arcPreviewInfo() -> some View {
            Views.ArcPreviewCell(
                icon: arcModel.icon,
                text: arcModel.name,
                frameWidth: Const.imageFrame,
                frameHeight: Const.imageFrame
            )
        }
        
        func arcFullInfo() -> some View {
            ContainerView {
                VStack {
                    KFImageView(url: URL(string: arcModel.image), cornerRadius: Const.imageViewCornerRadius)
                        .frame(height: Const.fullImageHeightFrame)
                        .frame(maxWidth: Const.fullImageWidthFrame)
                        .padding()
                    Text(arcModel.description)
                        .padding()
                }
            }
        }
    }
}
