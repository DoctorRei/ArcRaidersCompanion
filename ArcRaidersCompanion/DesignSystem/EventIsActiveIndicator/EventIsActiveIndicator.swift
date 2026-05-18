//
//  ActivityIndicator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.03.2026.
//

import SwiftUI

extension Views {
    struct EventIsActiveIndicator: View {
        private enum Const {
            static let frame: CGFloat = 14
        }
        
        var isActive: Bool

        var body: some View {
            Circle()
                .frame(width: Const.frame, height: Const.frame)
                .foregroundStyle(isActive ? .yellow : .red)
        }
    }
}
