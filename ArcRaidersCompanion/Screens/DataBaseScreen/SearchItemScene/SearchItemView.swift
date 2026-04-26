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
            customNavigationBar()
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
    
    func customNavigationBar() -> some View {
        HStack {
            if !viewModel.isSearchFocused {
                backButton()
                    .padding(.leading)
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
            Views.SearchTextView(
                searchText: $viewModel.text,
                scrollOffset: $viewModel.scrollOffset,
                isFocus: $viewModel.isSearchFocused,
                onTextChange: { text in
                    Task {
                        await viewModel.getItems(with: text)
                    }
                }
            )
            .padding(.trailing)
            .padding(.leading, viewModel.isSearchFocused ? Const.textFieldPadding : Const.textFieldPaddingBase)
        }
        .animation(.easeInOut(duration: Const.animationDuration), value: viewModel.isSearchFocused)
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
            Views.ArcInfoView.ArcLootList(lootList: viewModel.foundedItems)
                .onTapGesture {
                    navigateToSelectedItem()
                }
        }
    }
    
    func arcDescriptionCell(for model: [Views.ArcInfoView.Models.ArcModel.ArcLoot]) -> some View {
        Views.ArcInfoView.ArcLootList(lootList: model)
    }
}

extension SearchItemView {
    func navigateBack() {
        viewModel.navigateBack()
    }
    
    func navigateToSelectedItem() {
        viewModel.navigateToSelectedItem()
    }
}
