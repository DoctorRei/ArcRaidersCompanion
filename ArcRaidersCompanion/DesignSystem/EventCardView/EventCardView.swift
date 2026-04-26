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
        private enum Const {
            static let imageFrame: CGFloat = 124
            static let eventDateInfoSpacing: CGFloat = 6
            static let mapInfoViewSpacing: CGFloat = 6
            static let timeOfEventSpacing: CGFloat = 10
            
            enum Font {
                static let nameMapFontSize: CGFloat = 18
                static let nameEventFontSize: CGFloat = 16
            }
        }
        
        struct Model {
            var isActive: Bool
            var name: String
            var map: String
            var icon: String
            
            var formattedStartTime: String
            var formattedEndTime: String
            var formattedDateTime: String
            var id: String
        }
        
        let event: Model
        
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
                    Views.EventIsActiveIndicator(isActive: event.isActive)
                        .padding()
                }
        }
        .padding()
    }
    
    func cardBody(event: Model) -> some View {
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
            .frame(width: Const.imageFrame, height: Const.imageFrame, alignment: .center)
    }
    
    func eventDateInfo(startTimeText: String, endTimeText: String, dayText: String) -> some View {
        VStack(alignment: .center, spacing: Const.eventDateInfoSpacing) {
            dateOfEventView(with: dayText)
            timeOfEventView(startDateText: startTimeText, endDateText: endTimeText)
        }
    }
    
    func mapInfoView(with mapName: String, and eventName: String) -> some View {
        VStack(alignment: .center, spacing: Const.mapInfoViewSpacing) {
            nameMapView(with: mapName)
            nameEventView(with: eventName)
        }
    }
    
    func timeOfEventView(startDateText: String, endDateText: String) -> some View {
        HStack(alignment: .center, spacing: Const.timeOfEventSpacing) {
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
            .font(.system(size: Const.Font.nameMapFontSize))
    }
    
    func nameEventView(with text: String) -> some View {
        Text(text)
            .font(.system(size: Const.Font.nameEventFontSize))
    }
}
