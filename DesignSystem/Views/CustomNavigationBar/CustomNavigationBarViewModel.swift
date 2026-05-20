//
//  CustomNavigationBarViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.04.2026.
//

import SwiftUI

public extension Views.CustomNavigationBar {
    public enum NavigationBarStyle {
        case search(SearchConfiguration)
        case title(TitleConfiguration)
    }
    
    public struct SearchConfiguration {
        let searchText: Binding<String>
        let scrollOffset: Binding<CGFloat>
        let isSearchFocused: Binding<Bool>
        let onTextChange: (String) -> Void
        let backAction: (() -> Void)?
        
        public init(
            searchText: Binding<String>,
            scrollOffset: Binding<CGFloat> = .constant(0),
            isSearchFocused: Binding<Bool>,
            onTextChange: @escaping (String) -> Void,
            backAction: (() -> Void)? = nil
        ) {
            self.searchText = searchText
            self.scrollOffset = scrollOffset
            self.isSearchFocused = isSearchFocused
            self.onTextChange = onTextChange
            self.backAction = backAction
        }
    }
    
    // MARK: - Title Configuration
    public struct TitleConfiguration {
        public struct Favorites {
            let isFavorite: Binding<Bool>
            let action: (() -> Void)
            
            public init(isFavorite: Binding<Bool>, action: @escaping () -> Void) {
                self.isFavorite = isFavorite
                self.action = action
            }
        }
        
        let title: String
        let backAction: (() -> Void)?
        let favoriteButton: Favorites?
        var isLoading: Bool = false

        public init(
            title: String,
            backAction: (() -> Void)? = nil,
            favoriteButton: Favorites? = nil,
            isLoading: Bool = false
        ) {
            self.title = title
            self.backAction = backAction
            self.favoriteButton = favoriteButton
            self.isLoading = isLoading
        }
    }
}
