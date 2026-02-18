//
//  HomeViewModel.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI
import Combine

protocol HomeCoordinatorProtocol: AnyObject {
    func showFavorites()
}

extension HomeView {
    final class ViewModel: ObservableObject {
        weak var coordinator: HomeCoordinatorProtocol?
    }
}
