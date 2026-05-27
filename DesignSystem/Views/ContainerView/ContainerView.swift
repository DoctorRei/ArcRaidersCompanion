//
//  ContainerView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.03.2026.
//

import SwiftUI

public extension Views {
    struct ContainerView<Content: View>: View {
        private let content: Content
        private let color: Color
        
        public init(color: Color = .gray, @ViewBuilder content: () -> Content) {
            self.content = content()
            self.color = color
        }
        
        public var body: some View {
            content
                .frame(maxWidth: .infinity)
                .background(color.opacity(0.4))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}
