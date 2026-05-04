//
//  CustomNavigationBarViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.04.2026.
//

import SwiftUI

extension Views.CustomNavigationBar {
    enum NavigationBarStyle {
        case search(SearchConfiguration)
        case title(TitleConfiguration)
    }
    
    struct SearchConfiguration {
        let searchText: Binding<String>
        let scrollOffset: Binding<CGFloat>
        let isSearchFocused: Binding<Bool>
        let onTextChange: (String) -> Void
        let backAction: (() -> Void)?
        
        init(
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
    struct TitleConfiguration {
        let title: String
        let backAction: (() -> Void)?
        var isLoading: Bool = false

        init(
            title: String,
            backAction: (() -> Void)? = nil,
            isLoading: Bool = false
        ) {
            self.title = title
            self.backAction = backAction
            self.isLoading = isLoading
        }
    }
}
