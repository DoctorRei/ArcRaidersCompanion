//
//  StarButton.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import SwiftUI

extension Views {
    struct StarButton: View {
        private enum Const {
            static let starSize: CGFloat = 24
            static let brightYellow = Color.yellow
            static let inactiveGray = Color.gray.opacity(0.5)
        }

        @Binding var isSelected: Bool
        var action: () -> Void

        var body: some View {
            Button(action: {
                isSelected.toggle()
                action()
            }) {
                Image(systemName: isSelected ? "star.fill" : "star")
                    .resizable()
                    .frame(width: Const.starSize, height: Const.starSize)
                    .foregroundStyle(isSelected ? Const.brightYellow : Const.inactiveGray)
            }
            .buttonStyle(.plain)
        }
    }
}
