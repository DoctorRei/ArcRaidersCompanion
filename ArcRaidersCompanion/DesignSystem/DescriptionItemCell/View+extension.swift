//
//  View+extension.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 01.05.2026.
//

import SwiftUI

extension View {
    func baseCellStyle() -> some View {
        self
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(
                        color: .black.opacity(0.05),
                        radius: 5,
                        y: 2
                    )
            )
    }
}
