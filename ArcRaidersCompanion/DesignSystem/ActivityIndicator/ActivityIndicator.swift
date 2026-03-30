//
//  ActivityIndicator.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 27.03.2026.
//

import SwiftUI

extension Views {
    struct ActivityIndicator: View {
        var isActive: Bool

        var body: some View {
            Circle()
                .frame(width: 14, height: 14)
                .foregroundStyle(isActive ? .yellow : .red)
        }
    }
}
