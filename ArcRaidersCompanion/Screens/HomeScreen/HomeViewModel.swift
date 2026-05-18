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

extension HomeView {
    protocol ViewModelProtocol {
        associatedtype Event
        var events: [Event] { get set }
        func getEvents() async
    }
    
    final class ViewModel: ObservableObject {
        typealias Event = NetworkManager.Model.Event
        typealias CardModel = Views.EventCardView.Model
        weak var coordinator: HomeCoordinatorProtocol?
        private var networkManager = NetworkManager.shared
        
        var events: [Event] = []
        
        @Published private var isErrorLoading: Bool = false
        @Published var selectedPickerTab: PickerStyles = .actual

        @Published var activeEvents: [CardModel] = []
        @Published var upcomingEvents: [CardModel] = []
        @Published var finishedEvents: [CardModel] = []
    }
}

extension HomeView.ViewModel: HomeView.ViewModelProtocol {
    func getEvents() async {
        Task {
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
                let model = makeModel(from: event)
                activeEvents.append(model)
            case .upcoming:
                let model = makeModel(from: event)
                upcomingEvents.append(model)
            case .finished:
                let model = makeModel(from: event)
                finishedEvents.append(model)
            }
        }
    }
    
    func makeModel(from event: Event) -> CardModel {
        .init(
            isActive: event.isActive,
            name: event.name,
            map: event.map,
            icon: event.icon,
            formattedStartTime: event.formattedStartTime,
            formattedEndTime: event.formattedEndTime,
            formattedDateTime: event.formattedDateTime,
            id: event.id
        )
    }
}
