//
//  TraderInfoView+Models.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

extension Views.TraderInfoView {
    enum Models {}
}

extension Views.TraderInfoView.Models {
    struct TraderModel {
        let id: String
        let name: String
        let description: String
        let icon: String
        let image: String
    }
}

extension Views.TraderInfoView.Models.TraderModel {
    init(networkTrader: NetworkManager.Model.DataModels.TradersData.Trader) {
        self.id = networkTrader.id
        self.name = networkTrader.name
        self.description = networkTrader.description
        self.icon = networkTrader.icon
        self.image = networkTrader.image
    }
}
