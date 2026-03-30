//
//  DataBaseCollection.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

extension Views {
    struct DataBaseCollection: View {
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
                    "Arcs"
                case .quests:
                    "Quests"
                case .items:
                    "Items"
                case .traders:
                    "Traders"
                }
            }
        }

        let itemsTypes: [ItemType] = [.arcs, .items, .quests, .traders]
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            ScrollView {
                ForEach(itemsTypes, id: \.self) { item in
                    DataBaseCell(image: item.image, text: item.text)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
