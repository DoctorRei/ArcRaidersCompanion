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
        pickerView()
        content()
            .task {
                await viewModel.getEvents()
            }
            .toolbar(.hidden, for: .navigationBar)
    }
    
    func pickerView() -> some View {
        Picker("", selection: $viewModel.selectedPickerTab) {
            ForEach(PickerStyles.allCases) { style in
                Text(style.rawValue).tag(style)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            LazyVStack {
                switch viewModel.selectedPickerTab {
                case .actual:
                    ForEach(viewModel.activeEvents, id: \.id) { event in
                        Views.EventCardView(event: event)
                    }
                case .upcoming:
                    ForEach(viewModel.upcomingEvents, id: \.id) { event in
                        Views.EventCardView(event: event)
                    }
                case .finished:
                    ForEach(viewModel.finishedEvents, id: \.id) { event in
                        Views.EventCardView(event: event)
                    }
                }
            }
        }
    }
}
