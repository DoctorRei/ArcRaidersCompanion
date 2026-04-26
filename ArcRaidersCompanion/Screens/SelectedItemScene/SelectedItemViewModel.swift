//
//  SelectedItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import Combine
import Foundation

protocol SelectedItemNavigateProtocol: AnyObject {
    func navigateBack()
}

extension SelectedItemView {
    protocol ViewModelProtocol {}
    
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
    }
}

extension SelectedItemView.ViewModel {
    func navigateBack() {
        coordinator?.navigateBack()
    }
}
