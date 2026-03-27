//
//  EventCardView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 18.03.2026.
//

import SwiftUI
import Kingfisher

extension Views {
    struct EventCardView: View {
        let event: Event
        
        var body: some View {
            content()
        }
    }
}

private extension Views.EventCardView {
    func content() -> some View {
        Views.ContainerView {
            cardBody(event: event)
                .overlay(alignment: .topTrailing) {
                    Views.ActivityIndicator(isActive: event.isActive)
                        .padding()
                }
        }
    }
    
    func cardBody(event: Event) -> some View {
        VStack {
            HStack {
                loadedImageView(with: URL(string: event.icon))
                mapInfoView(with: event.map, and: event.name)
                    .frame(maxWidth: .infinity)
            }
            eventDateInfo(
                startTimeText: "\(event.formattedStartTime)",
                endTimeText: "\(event.formattedEndTime)",
                dayText: "\(event.formattedDateTime)"
            )
        }
    }
    
    func loadedImageView(with urlImage: URL?) -> some View {
        KFImageView(url: urlImage)
            .frame(width: 120, height: 120, alignment: .center)
    }
    
    func eventDateInfo(startTimeText: String, endTimeText: String, dayText: String) -> some View {
        VStack(alignment: .center, spacing: 6) {
            dateOfEventView(with: dayText)
            timeOfEventView(startDateText: startTimeText, endDateText: endTimeText)
        }
    }
    
    func mapInfoView(with mapName: String, and eventName: String) -> some View {
        VStack(alignment: .center, spacing: 6) {
            nameMapView(with: mapName)
            nameEventView(with: eventName)
        }
    }
    
    func timeOfEventView(startDateText: String, endDateText: String) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Text(startDateText)
            Text("-")
            Text(endDateText)
        }
    }
    
    func dateOfEventView(with text: String) -> some View {
        Text(text)
    }
    
    func nameMapView(with text: String) -> some View {
        Text(text)
            .font(.system(size: 18))
    }
    
    func nameEventView(with text: String) -> some View {
        Text(text)
            .font(.system(size: 16))
    }
}
