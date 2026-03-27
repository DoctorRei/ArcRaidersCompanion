//
//  KFimageView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.03.2026.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    let url: URL?
    var placeholder: AnyView?
    var errorView: AnyView?
    var configuration: KingfisherOptionsInfo?
    var cornerRadius: CGFloat = 0
    
    init(url: URL?,
         placeholder: AnyView? = nil,
         errorView: AnyView? = nil,
         configuration: KingfisherOptionsInfo? = nil,
         cornerRadius: CGFloat = 0) {
        self.url = url
        self.placeholder = placeholder
        self.errorView = errorView
        self.configuration = configuration
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if let url = url {
                KFImage.url(url, cacheKey: nil)
                    .setProcessor(DefaultImageProcessor.default)
                    .loadDiskFileSynchronously(false)
                    .cacheMemoryOnly(false)
                    .fade(duration: 0.25)
                    .forceTransition(true)
                    .placeholder { _ in
                        placeholder ?? AnyView(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        )
                    }
                    .onFailure { error in
                        print("Failed to load image: \(error.localizedDescription)")
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                placeholder ?? AnyView(
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                )
            }
        }
    }
}
