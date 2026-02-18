//
//  FavoritesHostingController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.02.2026.
//

import SwiftUI

final class FavoritesHostingController: HostingController<FavoritesView, FavoritesView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

private extension HomeHostingController {
    func setupUI() {
        title = "Favorites"
    }
}
