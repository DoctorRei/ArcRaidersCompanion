//
//  DataBaseHostingController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 29.03.2026.
//

import SwiftUI

final class DataBaseHostingController: HostingController<DataBaseView, DataBaseView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
    }
}

