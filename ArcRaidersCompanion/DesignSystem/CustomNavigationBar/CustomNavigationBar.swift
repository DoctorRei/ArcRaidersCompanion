//
//  CustomNavigationBar.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.04.2026.
//

import SwiftUI

extension Views {
    struct CustomNavigationBar: View {
        private enum Const {
            static let textFieldPadding: CGFloat = 16
            static let textFieldPaddingBase: CGFloat = 0
            static let animationDuration: CGFloat = 0.15
            static let chevronLeftFrame: CGFloat = 44
            static let chevronBackGroundFrame: CGFloat = 36

            static let chevronImage: String = "chevron.left"
        }
        let navigationBarStyle: NavigationBarStyle
        var showBackButton: Bool = true
        
        // MARK: - Body
        var body: some View {
            content()
        }
        
        @ViewBuilder
        func content() -> some View {
            switch navigationBarStyle {
            case .search(let config):
                searchNavigationBar(with: config)
            case .title(let config):
                navigationBarTitle(with: config)
            }
        }
        
        private func searchNavigationBar(with config: SearchConfiguration) -> some View {
            HStack(spacing: 0) {
                if !config.isSearchFocused.wrappedValue && showBackButton {
                    backButton(action: config.backAction)
                        .padding(.leading)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
                SearchTextView(
                    searchText: config.searchText,
                    scrollOffset: config.scrollOffset,
                    isFocus: config.isSearchFocused,
                    onTextChange: config.onTextChange
                )
                .padding(.trailing)
                .padding(.leading,
                         config.isSearchFocused.wrappedValue
                            ? Const.textFieldPadding
                            : Const.textFieldPaddingBase)
            }
            .animation(.easeInOut(duration: Const.animationDuration), value: config.isSearchFocused.wrappedValue)
        }
        
        private func navigationBarTitle(with config: TitleConfiguration) -> some View {
            HStack(alignment: .center, spacing: 0) {
                if showBackButton {
                    backButton(action: config.backAction)
                        .padding(.leading)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
                
                Text(config.title)
                    .font(.custom("SF Pro Display", size: 18, relativeTo: .title2))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
        }

        private func backButton(action: (() -> Void)?) -> some View {
            Button {
                if let backAction = action {
                    backAction()
                }
            } label: {
                Image(systemName: Const.chevronImage)
                    .foregroundColor(.black)
                    .frame(width: Const.chevronLeftFrame, height: Const.chevronLeftFrame)
                    .background(
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: Const.chevronBackGroundFrame, height: Const.chevronBackGroundFrame)
                    )
                    .contentShape(Rectangle())
            }
        }
    }
}
