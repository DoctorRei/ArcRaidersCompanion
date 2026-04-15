//
//  SearchBarViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 15.04.2026.
//

import SwiftUI

extension Views.SearchTextView {
    struct ViewModel {
        let id: String
        let image: String
        let name: String
        
        // TODO: - Сделать интернал модель
        let mainModel: NetworkManager.Model.DataModels.ItemsData.Item
    }
    
}
