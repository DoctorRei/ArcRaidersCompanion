//
//  TraderPreviewCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

extension Views.TraderInfoView {
    struct TraderPreviewCell: View {
        var icon: String?
        var text: String
        var frameWidth: CGFloat
        var frameHeight: CGFloat

        var body: some View {
            content()
        }

        func content() -> some View {
            Views.ContainerView {
                HStack {
                    image()
                        .frame(width: frameWidth, height: frameHeight)
                        .padding(.horizontal)
                    Text(text)
                        .frame(maxWidth: .infinity)
                }
            }
        }

        @ViewBuilder
        func image() -> some View {
            if let icon {
                KFImageView(url: URL(string: icon))
            } else {
                Image(systemName: icon ?? "person.fill")
            }
        }
    }
}
