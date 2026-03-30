//
//  DataBaseViewModel.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI
import Combine

protocol DataBaseCoordinatorProtocol: AnyObject {
}

extension DataBaseView {
    final class ViewModel: ObservableObject {
        weak var coordinator: DataBaseCoordinatorProtocol?
    }
}
