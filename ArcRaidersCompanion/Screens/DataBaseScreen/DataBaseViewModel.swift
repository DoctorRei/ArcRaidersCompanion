//
//  DataBaseViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI
import Combine

extension DataBaseView {
    final class ViewModel: ObservableObject {
        weak var coordinator: DataBaseCoordinatorProtocol?
    }
}

extension DataBaseView.ViewModel {
    func showArcsScene() {
        coordinator?.showArcsScene()
    }

    func showTradersScene() {
        coordinator?.showTradersScene()
    }

    func showSearchItemScene() {
        coordinator?.showSearchItemScene()
    }
}
