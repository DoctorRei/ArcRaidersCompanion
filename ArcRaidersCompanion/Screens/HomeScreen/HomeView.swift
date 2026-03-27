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
        contentV2()
            .task {
                await viewModel.getEvents()
            }
    }
    
    @ViewBuilder
    func contentV2() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.events, id: \.id) { event in
                    Views.EventCardView(event: event)
                }
            }
        }
    }
}
