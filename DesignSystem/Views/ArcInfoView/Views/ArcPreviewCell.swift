//
//  ArcPreviewCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views.ArcInfoView {
    struct ArcPreviewCell: View {
        enum Const {
            static let borderWidth: CGFloat = 3
        }
        
        var icon: String?
        var text: String
        var frameWidth: CGFloat
        var frameHeight: CGFloat
        var uiImage: UIImage?
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            Views.ContainerView {
                HStack {
                    image()
                        .frame(width: frameWidth, height: frameHeight)
                        .padding()
                    Text(text)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        
        @ViewBuilder
        func image() -> some View {
            if let icon {
                KFImageView(url: URL(string: icon))
            } else if let uiImage {
                imageWithBorder(image: uiImage)
            } else {
                Image(systemName: icon ?? "heart.fill")
            }
        }
        
        func imageWithBorder(image: UIImage) -> some View {
            Image(uiImage: image)
                .resizable()
                .clipShape(.circle)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: Const.borderWidth)
                )
        }
    }
}
