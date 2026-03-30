//
//  DataBaseViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI
import Combine

extension DataBaseView {
    protocol ViewModelProtocol {
        associatedtype Arcs
        func getArcs() async
    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: DataBaseCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false
        private var arcModels: [NetworkManager.Model.ARCEnemy] = []
        
    }
}

extension DataBaseView.ViewModel: DataBaseView.ViewModelProtocol {
    typealias Arcs = NetworkManager.Model.ARCEnemy
    
    func getArcs() async {
        Task {
            do {
                try await arcModels = networkManager.fetchArcs()
                print(arcModels)
            } catch {
                isErrorLoading = true
                print(isErrorLoading)
            }
        }
    }
}

extension DataBaseView.ViewModel {
    func showArcsScene() {
        print("TESTTEST DataBase ViewModel ShowArcsScene")
        coordinator?.showArcsScene()
    }
}
