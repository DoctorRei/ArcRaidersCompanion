//
//  ArcItemsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import SwiftUI
import DesignSystem

struct SearchItemView: View {
    private enum Const {
        static let textFieldPadding: CGFloat = 16
        static let textFieldPaddingBase: CGFloat = 0
        static let animationDuration: CGFloat = 0.15
        static let chevronLeftFrame: CGFloat = 44
        static let chevronBackGroundFrame: CGFloat = 36
        
        static let errorMessage: String = "Sorry, but we not found your item"
        static let greetingsMessage: String = "Use text field to find your item"
    }
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content()
        .onTapGesture {
            hideKeyboard()
            viewModel.isSearchFocused = false
        }
    }
}

extension SearchItemView {
    @ViewBuilder
    func content() -> some View {
        VStack(spacing: 6) {
            Views.CustomNavigationBar(
                navigationBarStyle: .search(
                    .init(
                        searchText: $viewModel.text,
                        scrollOffset: $viewModel.scrollOffset,
                        isSearchFocused: $viewModel.isSearchFocused) { text in
                            Task {
                                await viewModel.getItems(with: text)
                            }
                        } backAction: {
                            navigateBack()
                        }
                    )
                )

            searchItemsView()
                .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func searchItemsView() -> some View {
        switch (viewModel.isErrorLoading, viewModel.isLoading) {
        case (false, true):
            loader()
        case (true, false):
            Text(Const.errorMessage)
        case (false, false):
            mainContent()
        case (true, true):
            Text(Const.errorMessage)
        }
    }
    
    @ViewBuilder
    func mainContent() -> some View {
        switch viewModel.foundedMiniItems.isEmpty {
        case true:
            greetingsView()
        case false:
            listOfItems()
        }
    }
    
    func loader() -> some View {
        Views.ActivityIndicator()
    }
    
    func greetingsView() -> some View {
        Text(Const.greetingsMessage)
    }
    
    func listOfItems() -> some View {
        ScrollView {
            Views.ArcInfoView.ArcLootList(lootList: viewModel.foundedMiniItems) { item in
                navigateToSelectedItem(with: item.id)
            }
        }
    }
}

extension SearchItemView {
    func navigateBack() {
        viewModel.navigateBack()
    }
    
    func navigateToSelectedItem(with id: String) {
        viewModel.navigateToSelectedItem(with: id)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
