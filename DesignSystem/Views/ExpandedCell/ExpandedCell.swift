//
//  ArcInfo.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views {
    public struct ExpandedCell<Header: View, Content: View>: View {
        public enum Spacing {
            case none
            case small
            case medium
            case large
            
            var padding: CGFloat {
                switch self {
                case .none:
                    0
                case .small:
                    4
                case .medium:
                    8
                case .large:
                    26
                }
            }
        }
        
        let header: Header
        let spacing: CGFloat
        let cellContent: Content
        let isExpanded: Binding<Bool>
        
        public init(isExpanded: Binding<Bool>,
             spacing: Spacing,
             @ViewBuilder header: () -> Header,
             @ViewBuilder content: () -> Content) {
            self.header = header()
            self.cellContent = content()
            self.isExpanded = isExpanded
            self.spacing = spacing.padding
        }
        
        public var body: some View {
            content()
        }
        
        func content() -> some View {
            VStack(alignment: .leading, spacing: spacing) {
                Button {
                    isExpanded.wrappedValue.toggle()
                } label: {
                    header
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.white, lineWidth: isExpanded.wrappedValue ? 3 : 0)
                        )
                    
                }
                .buttonStyle(.plain)
                
                if isExpanded.wrappedValue {
                    cellContent
                }
            }
        }
    }
}
