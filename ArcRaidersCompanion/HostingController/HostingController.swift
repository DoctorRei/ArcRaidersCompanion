//
//  HostingController.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI

class HostingController<Content: View, ViewModel: AnyObject>: UIHostingController<Content> {
    var viewModel: ViewModel
    
    init(rootView: Content, viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(rootView: rootView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
