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
        Views.CustomNavigationBar(
            navigationBarStyle: .title(
                .init(
                    title: viewModel.item.name,
                    backAction: {
                        viewModel.navigateBack()
                    })
            )
        )
        ScrollView {
            content()
        }
    }
}

extension SelectedItemView {
    func content() -> some View {
        VStack(alignment: .center, spacing: 12) {
            itemImageView()
            itemDescriptionView()
            itemBaseInfoView()
            itemCharacteristicsView()
        }
    }
    
    func itemImageView() -> some View {
        KFImageView(url: URL(string: viewModel.item.icon))
            .padding()
    }
    
    func itemDescriptionView() -> some View {
        Text(viewModel.item.description)
            .font(.body)
            .foregroundColor(.secondary)
            .lineSpacing(4)
    }
    
    func itemBaseInfoView() -> some View {
        Views.ExpandedCell(
            isExpanded: $viewModel.isExpandedBasicInfo,
            spacing: .small) {
                Text("Basic info")
                    .frame(height: 50, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            } content: {
                Views.DescriptionItemCell(itemModel: viewModel.item, selectedType: .baseInfo)
            }
    }
    
    func itemCharacteristicsView() -> some View {
        Views.ExpandedCell(
            isExpanded: $viewModel.isExpandedItemCharacteristics,
            spacing: .large) {
                Text("Characteristic")
                    .frame(height: 100, alignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
            } content: {
                Views.DescriptionItemCell(itemModel: viewModel.item, selectedType: .fullInfo)
            }

    }
}
