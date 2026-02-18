//
//  MainView.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeView.ViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Home view")
        }
    }
}
