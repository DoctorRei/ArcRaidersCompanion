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

protocol ViewModelProtocol {
    var events: [Event] { get }
    func getEvents() async
}

extension HomeView {
    final class ViewModel: ObservableObject {
        weak var coordinator: HomeCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        
        @Published var events: [Event] = []
        @Published private var isErrorLoading: Bool = false
    }
}

extension HomeView.ViewModel: ViewModelProtocol {
    func getEvents() async {
        Task {
            do {
                try await events = networkManager.fetchEvents()
            } catch {
                isErrorLoading = true
            }
        }
    }
}
