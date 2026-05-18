//
//  ArcItemsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import SwiftUI

struct SearchItemView: View {
    private enum Const {
        static let textFieldPadding: CGFloat = 16
        static let textFieldPaddingBase: CGFloat = 0
        static let animationDuration: CGFloat = 0.15
        static let chevronLeftFrame: CGFloat = 44
        static let chevronBackGroundFrame: CGFloat = 36

        static let chevronImage: String = "chevron.left"
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
            Text("Sorry, but we not found your item")
        case (false, false):
            listOfItems()
        case (true, true):
            Text("Sorry, but we not found your item")
        }
    }
    
    func backButton() -> some View {
        Button {
            navigateBack()
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
    
    func loader() -> some View {
        Views.ActivityIndicator()
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
}
