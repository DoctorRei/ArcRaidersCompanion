//
//  MainView.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeView.ViewModel
    
    init(viewModel: HomeView.ViewModel) {
        self.viewModel = viewModel
        getEvents()
    }
    
    var body: some View {
        content()
            .toolbar(.hidden, for: .navigationBar)
    }
}

private extension HomeView {
    func content() -> some View {
        VStack {
            pickerView()
                .padding(.horizontal)
            cards()
        }
    }
    
    func pickerView() -> some View {
        Picker(String(), selection: $viewModel.selectedPickerTab) {
            ForEach(PickerStyles.allCases) { style in
                Text(style.rawValue).tag(style)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    func cards() -> some View {
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

private extension HomeView {
    func getEvents() {
        Task {
            await viewModel.getEvents()
        }
    }
}
