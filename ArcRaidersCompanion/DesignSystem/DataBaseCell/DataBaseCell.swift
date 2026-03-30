//
//  DataBaseCell.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

extension Views {
    struct DataBaseCell: View {
        private let image: UIImage
        private let text: String
        
        init(image: UIImage, text: String) {
            self.image = image
            self.text = text
        }
        
        var body: some View {
            content()
                .navigationTitle("Data Base")
        }
    }
}

extension Views.DataBaseCell {
    private func content() -> some View {
        Button {
            print("Press Me")
        } label: {
            Views.ContainerView {
                HStack {
                    imageWithBorder()
                        .padding()
                    Text(text)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func imageWithBorder() -> some View {
        Image(uiImage: image)
            .frame(width: 124, height: 124)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 3)
            )
    }
}

