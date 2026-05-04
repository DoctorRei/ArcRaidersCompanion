//
//  TradersViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Combine
import Foundation

protocol TradersCoordinatorProtocol: AnyObject {
    func navigateBack()
    func showItemDetails(id: String)
}

extension TradersView {
    protocol ViewModelProtocol {
        func getTraders() async
    }

    final class ViewModel: ObservableObject {
        weak var coordinator: TradersCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false

        @Published var traders: [TraderModel] = []
    }
}

extension TradersView.ViewModel: TradersView.ViewModelProtocol {
    func getTraders() async {
        Task {
            do {
                let networkTraders = try await networkManager.fetchTraders()
                sortTraders(networkTraders)
            } catch {
                isErrorLoading = true
            }
        }
    }

    func sortTraders(_ model: [NetworkManager.Model.DataModels.TradersData.Trader]) {
        traders = model.map { trader in
            let items = trader.items.map { TraderItemModel(networkItem: $0) }
                .sorted { $0.rarity.priority > $1.rarity.priority }
            return TraderModel(id: trader.id, name: trader.name, items: items)
        }
    }

    func showItemDetails(id: String) {
        coordinator?.showItemDetails(id: id)
    }
}

extension TradersView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
