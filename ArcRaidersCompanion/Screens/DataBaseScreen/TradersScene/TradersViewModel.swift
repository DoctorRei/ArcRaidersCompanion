//
//  TradersViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import Combine

protocol TradersCoordinatorProtocol: AnyObject {
    func navigateBack()
}

extension TradersView {
    protocol ViewModelProtocol {
        func getTraders() async
    }

    final class ViewModel: ObservableObject {
        typealias TraderModel = Views.TraderInfoView.Models.TraderModel

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
        traders = model.map { TraderModel(networkTrader: $0) }
    }
}

extension TradersView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
