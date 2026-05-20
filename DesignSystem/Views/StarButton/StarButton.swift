//
//  StarButton.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.05.2026.
//

import SwiftUI

extension Views {
    public struct StarButton: View {
        private enum Const {
            static let starSizeS: CGFloat = 24
            static let backgroundCircleFrame: CGFloat = 36
            static let brightYellow = Color.yellow
            static let inactiveGray = Color.white
        }
        var configuration: Configuration
        @Binding var isSelected: Bool
        var action: () -> Void
        
        public init(
            configuration: Configuration,
            isSelected: Binding<Bool>,
            action: @escaping () -> Void
        ) {
            self.configuration = configuration
            self._isSelected = isSelected
            self.action = action
        }

        public var body: some View {
            content()
        }
    }
}

extension Views.StarButton {
    @ViewBuilder
    func content() -> some View {
        switch configuration {
        case .cell:
            starButton(size: Const.starSizeS)
        case .navBar:
            starButton(size: Const.starSizeS)
                .background(
                    Circle()
                        .foregroundStyle(isSelected ? .white : .gray)
                        .frame(width: Const.backgroundCircleFrame, height: Const.backgroundCircleFrame)
                )
        }
    }
    
    func starButton(size: CGFloat) -> some View {
        Button(action: {
            isSelected.toggle()
            action()
        }) {
            Image(systemName: isSelected ? "star.fill" : "star")
                .resizable()
                .frame(width: size, height: size)
                .foregroundStyle(isSelected ? Const.brightYellow : Const.inactiveGray)
        }
        .buttonStyle(.plain)
    }
}

extension Views.StarButton {
    public enum Configuration {
        case cell
        case navBar
    }
}
