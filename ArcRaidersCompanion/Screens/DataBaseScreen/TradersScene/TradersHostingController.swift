//
//  TradersHostingController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 02.05.2026.
//

import SwiftUI

final class TradersHostingController: HostingController<TradersView, TradersView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
        navigationController?.navigationBar.isHidden = true
    }
}
