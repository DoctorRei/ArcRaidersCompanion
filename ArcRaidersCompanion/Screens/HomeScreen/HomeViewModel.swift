//
//  HomeViewModel.swift
//  ArcRaidersDataBase
//
//  Created by Akira Rei on 17.02.2026.
//

import SwiftUI
import Combine

enum PickerStyles: String, CaseIterable, Identifiable {
    case actual = "Actual"
    case upcoming = "Upcoming"
    case finished = "Finished"
    
    var id: String { self.rawValue }
}

protocol HomeCoordinatorProtocol: AnyObject {
    func showFavorites()
}

protocol ViewModelProtocol {
    var events: [Event] { get set }
    func getEvents() async
}

extension HomeView {
    final class ViewModel: ObservableObject {
        weak var coordinator: HomeCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        
        var events: [Event] = []
        @Published private var isErrorLoading: Bool = false
        @Published var selectedPickerTab: PickerStyles = .actual

        @Published var activeEvents: [Event] = []
        @Published var upcomingEvents: [Event] = []
        @Published var finishedEvents: [Event] = []
    }
}

extension HomeView.ViewModel: ViewModelProtocol {
    func getEvents() async {
        Task {
            print("TESTTEST We take another Events")
            do {
                try await events = networkManager.fetchEvents()
                filterEvents(with: events)
            } catch {
                isErrorLoading = true
            }
        }
    }
}

extension HomeView.ViewModel {
    func filterEvents(with events: [Event]) {
        events.forEach { event in
            switch event.status {
            case .active:
                activeEvents.append(event)
            case .upcoming:
                upcomingEvents.append(event)
            case .finished:
                finishedEvents.append(event)
            }
        }
    }
}
