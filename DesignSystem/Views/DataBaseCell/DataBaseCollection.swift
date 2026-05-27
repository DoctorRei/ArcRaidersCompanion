//
//  DataBaseCollection.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

public extension Views {
    struct DataBaseCollection: View {
        private enum Const {
            static let arcsTitle: String = "Arcs"
            static let itemsTitle: String = "Items"
            static let tradersTitle: String = "Traders"
        }
        
        public enum ItemType: Hashable {
            case arcs
            case items
            case traders
            
            var image: UIImage {
                switch self {
                case .arcs:
                        .ArcTypes.arcs
                case .items:
                        .ArcTypes.items
                case .traders:
                        .ArcTypes.traders
                }
            }
            
            var text: String {
                switch self {
                case .arcs:
                    Const.arcsTitle
                case .items:
                    Const.itemsTitle
                case .traders:
                    Const.tradersTitle
                }
            }
        }
        
        private let itemsTypes: [ItemType] = [.arcs, .items, .traders]
        public let typeSelected: (ItemType) -> Void
        
        public init(typeSelected: @escaping (ItemType) -> Void) {
            self.typeSelected = typeSelected
        }
        
        public var body: some View {
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
