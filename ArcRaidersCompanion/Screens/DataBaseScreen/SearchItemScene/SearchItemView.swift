//
//  ArcItemsView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import SwiftUI

struct SearchItemView: View {
    private enum Const {
        static let imageFrame: CGFloat = 124
    }
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            Text("Hello")
        }
        .onTapGesture {
            hideKeyboard()
            viewModel.isSearchFocused = false
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
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
                    .frame(minWidth: 200, idealWidth: 500, maxWidth: .infinity)
            }
        }
        .toolbarRole(.editor)
        .navigationBarBackButtonHidden(viewModel.isSearchFocused)
    }
}

extension SearchItemView {
    func content() -> some View {
        Text("")
    }
    
    func listOfItems() {
        
    }
}
