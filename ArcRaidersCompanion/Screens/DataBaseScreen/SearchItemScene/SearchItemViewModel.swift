//
//  ArcItemViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 05.04.2026.
//

import SwiftUI
import Combine

protocol SearchItemNavigateProtocol: AnyObject {
    func navigateBack()
    func showItemDetails()
}

extension SearchItemView {
    final class ViewModel: ObservableObject {
        weak var coordinator: SearchItemNavigateProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false
    }
}

extension ArcsView.ViewModel {}
