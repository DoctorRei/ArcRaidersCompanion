//
//  DataBaseCollection.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

extension Views {
    struct DataBaseCollection: View {
        private enum Const {
            static let arcsTitle: String = "Arcs"
            static let questsTitle: String = "Quests"
            static let itemsTitle: String = "Items"
            static let tradersTitle: String = "Traders"
        }
        
        enum ItemType: Hashable {
            case arcs
            case quests
            case items
            case traders
            
            var image: UIImage {
                switch self {
                case .arcs:
                        .arcs
                case .quests:
                        .quests
                case .items:
                        .items
                case .traders:
                        .traders
                }
            }
            
            var text: String {
                switch self {
                case .arcs:
                    Const.arcsTitle
                case .quests:
                    Const.questsTitle
                case .items:
                    Const.itemsTitle
                case .traders:
                    Const.tradersTitle
                }
            }
        }
        
        private let itemsTypes: [ItemType] = [.arcs, .items, .quests, .traders]
        let typeSelected: (ItemType) -> Void
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            ScrollView {
                ForEach(itemsTypes, id: \.self) { item in
                    cell(item: item)
                }
                .padding(.horizontal)
            }
        }
        
        func cell(item: ItemType) -> some View {
            Button {
                typeSelected(item)
            } label: {
                DataBaseCell(image: item.image, text: item.text)
            }
            .buttonStyle(.plain)
        }
    }
}
