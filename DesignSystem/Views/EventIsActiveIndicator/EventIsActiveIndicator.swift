//
//  ActivityIndicator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.03.2026.
//

import SwiftUI

extension Views {
    public struct EventIsActiveIndicator: View {
        private enum Const {
            static let frame: CGFloat = 14
        }
        
        public init(isActive: Bool) {
            self.isActive = isActive
        }
        
        var isActive: Bool

        public var body: some View {
            Circle()
                .frame(width: Const.frame, height: Const.frame)
                .foregroundStyle(isActive ? .yellow : .red)
        }
    }
}
