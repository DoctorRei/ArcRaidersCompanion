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
}

extension TradersView {
    protocol ViewModelProtocol {
        func getTraders() async
    }

    final class ViewModel: ObservableObject {
        typealias TraderModel = TradersView.TraderModel

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
                print("TESTTEST \(networkTraders)")
                sortTraders(networkTraders)
            } catch {
                isErrorLoading = true
                print("TESTTEST \(error.localizedDescription)")
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
