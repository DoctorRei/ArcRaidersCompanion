//
//  ArcsViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI
import Combine

protocol ArcsCoordinatorProtocol: AnyObject {
}

extension ArcsView {
//    protocol ViewModelProtocol {
//        associatedtype Arcs
//        func getArcs() async
//    }
    
    final class ViewModel: ObservableObject {
        weak var coordinator: ArcsCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        private var isErrorLoading = false
        private var arcModels: [NetworkManager.Model.ARCEnemy] = []
        
    }
}

//extension ArcsView.ViewModel: DataBaseView.ViewModelProtocol {
//    typealias Arcs = NetworkManager.Model.ARCEnemy
//    
//    func getArcs() async {
//        Task {
//            do {
//                try await arcModels = networkManager.fetchArcs()
//                print(arcModels)
//            } catch {
//                isErrorLoading = true
//                print(isErrorLoading)
//            }
//        }
//    }
//}

