//
//  ArcDescriptionCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

//struct ARCEnemy: Identifiable, Decodable {
//    let id: String
//    let name: String
//    let description: String
//    let icon: String
//    let image: String
//    let createdAt: String
//    let updatedAt: String
//}

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
            HStack(alignment: .center, spacing: 12) {
                KFImageView(url: URL(string: arcModel.icon))
                    .frame(width: 124, height: 124)
                Text(arcModel.name)
            }
        }
        
        func arcFullInfo() -> some View {
            ContainerView {
                VStack {
                    KFImageView(url: URL(string: arcModel.image), cornerRadius: 16)
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                    Text(arcModel.description)
                    Text(arcModel.updatedAt)
                        .padding()
                }
            }
        }
    }
}
