//
//  DataBaseCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

public extension Views {
    struct DataBaseCell: View {
        private enum Const {
            static let navigationTitle: String = "Data Base"
            static let imageFrame: CGFloat = 124
            static let circleBorder: CGFloat = 3
        }
        
        private let image: UIImage
        private let text: String
        
        public init(image: UIImage, text: String) {
            self.image = image
            self.text = text
        }
        
        public var body: some View {
            content()
                .navigationTitle(Const.navigationTitle)
        }
    }
}

extension Views.DataBaseCell {
    private func content() -> some View {
        Views.ContainerView {
            HStack {
                imageWithBorder()
                    .padding()
                Text(text)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    func imageWithBorder() -> some View {
        Image(uiImage: image)
            .frame(width: Const.imageFrame, height: Const.imageFrame)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: Const.circleBorder)
            )
    }
}

