//
//  SelectedItemView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import SwiftUI
import DesignSystem

struct SelectedItemView: View {
    private enum Const {
        enum Spacing {
            static let section: CGFloat = 12
            static let content: CGFloat = 4
            static let lineSpacing: CGFloat = 4
        }
        enum Sizes {
            static let headerHeight: CGFloat = 44
        }
        enum Strings {
            static let basicInfo: String = "Basic Info"
            static let stats: String = "Stats"
            static let location: String = "Location"
            static let guides: String = "Guides"
            static let loading: String = "Loading... "
        }
    }

    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Views.CustomNavigationBar(
            navigationBarStyle: .title(
                .init(
                    title: viewModel.item?.name ?? Const.Strings.loading,
                    backAction: {
                        viewModel.navigateBack()
                    },
                    favoriteButton: .init(isFavorite: $viewModel.isFavorite, action: {
                        viewModel.favoriteButtonPressed()
                    })
                )
            )
        )
        if viewModel.isLoading || viewModel.item == nil {
            Views.ActivityIndicator()
                .frame(maxHeight: .infinity)
        } else {
            ScrollView {
                content()
                    .padding(.horizontal)
            }
        }
    }
}

extension SelectedItemView {
    func content() -> some View {
        VStack(alignment: .leading, spacing: Const.Spacing.section) {
            if let item = viewModel.item {
                itemImageView(item: item)
                itemDescriptionView(item: item)
                if viewModel.hasBasicInfo {
                    section(title: Const.Strings.basicInfo) {
                        Views.DescriptionItemCell(itemModel: viewModel.returnItemModel(from: item), selectedType: .baseInfo)
                    }
                }
                if viewModel.hasStats {
                    section(title: Const.Strings.stats) {
                        Views.DescriptionItemCell(itemModel: viewModel.returnItemModel(from: item), selectedType: .fullInfo)
                    }
                }
                if viewModel.hasLocations {
                    section(title: Const.Strings.location) {
                        Views.DescriptionItemCell(itemModel: viewModel.returnItemModel(from: item), selectedType: .locations)
                    }
                }
                if viewModel.hasGuides {
                    section(title: Const.Strings.guides) {
                        Views.DescriptionItemCell(itemModel: viewModel.returnItemModel(from: item), selectedType: .guides)
                    }
                }
            }
        }
        .padding(.vertical)
    }

    func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: Const.Spacing.content) {
            Text(title)
                .font(.headline)
                .frame(height: Const.Sizes.headerHeight)
            content()
        }
    }

    func itemImageView(item: SearchItemView.ViewModel.FoundedItem.Item) -> some View {
        Views.KFImageView(url: URL(string: item.icon))
            .padding()
    }

    func itemDescriptionView(item: SearchItemView.ViewModel.FoundedItem.Item) -> some View {
        Group {
            if !item.description.isEmpty {
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(Const.Spacing.lineSpacing)
            }
        }
    }
}
