//
//  ArcItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import Combine
import Foundation

protocol SearchItemNavigateProtocol: AnyObject {
    func navigateBack()
    func showItemDetails()
}

extension SearchItemView {
    protocol ViewModelProtocol {
        func getItems() async
    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false
    }
}

extension SearchItemView.ViewModel: SearchItemView.ViewModelProtocol {
    func getItems() async {
        do {
            let item = try await networkManager.fetchItem(id: "acoustic-guitar")
        } catch {
            print(error.localizedDescription)
        }
    }
}
