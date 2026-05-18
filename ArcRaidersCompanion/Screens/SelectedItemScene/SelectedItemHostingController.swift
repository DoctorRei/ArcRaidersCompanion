//
//  SelectedItemHostingController.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import SwiftUI

final class SelectedItemHostingController: HostingController<SelectedItemView, SelectedItemView.ViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
        navigationController?.navigationBar.isHidden = true
    }
}
