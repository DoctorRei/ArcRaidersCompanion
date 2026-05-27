//
//  ActivityIndicator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 26.04.2026.
//

import SwiftUI

public extension Views {
    struct ActivityIndicator: View {
        private enum Const {
            static let scaleEffect: CGFloat = 1.5
        }
        
        public init() {}

        public var body: some View {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(Const.scaleEffect)
        }
    }
}
