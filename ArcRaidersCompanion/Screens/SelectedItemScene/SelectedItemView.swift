//
//  SelectedItemView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import SwiftUI

struct SelectedItemView: View {
    private enum Const {}

    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("")
            .onAppear {
                viewModel.printTest()
            }
    }
}
