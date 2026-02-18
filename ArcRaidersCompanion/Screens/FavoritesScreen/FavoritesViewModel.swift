//
//  FavoritesViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import SwiftUI
import Combine

protocol FavoritesCoordinatorProtocol: AnyObject {
}

extension FavoritesView {
    final class ViewModel: ObservableObject {
        weak var coordinator: FavoritesCoordinatorProtocol?
        
    }
}
