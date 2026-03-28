//
//  HomeHostingController.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI

final class HomeHostingController: HostingController<HomeView, HomeView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
    }
}
