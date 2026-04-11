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
            content()
                .task {
                    await viewModel.getItems()
                }
        }
    }
}

extension SearchItemView {
    func content() -> some View {
        Text("Text")
    }
}
