//
//  ArcLoot.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.04.2026.
//

import SwiftUI

extension Views.ArcInfoView.ArcLootList {
    public struct ArcLootCell: View {
        public typealias Item = Views.Models.ArcModels.Arc.ArcLoot.LootItem
        let lootModel: Item
        var completion: (Item) -> Void
        
        public init(lootModel: Item, completion: @escaping (Item) -> Void) {
            self.lootModel = lootModel
            self.completion = completion
        }

        public var body: some View {
            content()
                .onTapGesture {
                    completion(lootModel)
                }
                .background(lootModel.color)
        }
    }
}

extension Views.ArcInfoView.ArcLootList.ArcLootCell {
    func content() -> some View {
        HStack {
            Views.KFImageView(url: URL(string: lootModel.icon))
                .frame(width: 24, height: 24)
            Text(lootModel.name)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
