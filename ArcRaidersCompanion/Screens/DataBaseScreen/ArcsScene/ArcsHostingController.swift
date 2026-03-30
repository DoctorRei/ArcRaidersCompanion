//
//  ArcsHostingController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 30.03.2026.
//

import SwiftUI

final class ArcsHostingController: HostingController<ArcsView, ArcsView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
        view.backgroundColor = .red
    }
}

