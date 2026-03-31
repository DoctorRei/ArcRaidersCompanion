//
//  ArcDescriptionCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views {
    struct ArcDescriptionCell: View {
        @State private var isExpanded = false
        var arcModel: NetworkManager.Model.ARCEnemy
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            ArcExpandedCell(isExpanded: $isExpanded) {
                arcPreviewInfo()
            } content: {
                arcFullInfo()
            }
        }
        
        func arcPreviewInfo() -> some View {
            Views.ArcPreviewCell(
                icon: arcModel.icon,
                text: arcModel.name,
                frameWidth: 64,
                frameHeight: 64
            )
        }
        
        func arcFullInfo() -> some View {
            ContainerView {
                VStack {
                    KFImageView(url: URL(string: arcModel.image), cornerRadius: 16)
                        .frame(height: 200)
                        .frame(maxWidth: 250)
                        .padding()
                    Text(arcModel.description)
                        .padding()
                }
            }
        }
    }
}
