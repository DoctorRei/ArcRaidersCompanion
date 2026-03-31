//
//  ArcInfo.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 31.03.2026.
//

import SwiftUI

extension Views {
    // MARK: - Основной компонент
    struct ArcExpandedCell<Header: View, Content: View>: View {
        let header: Header
        let cellContent: Content
        let isExpanded: Binding<Bool>
        
        init(isExpanded: Binding<Bool>,
             @ViewBuilder header: () -> Header,
             @ViewBuilder content: () -> Content) {
            self.header = header()
            self.cellContent = content()
            self.isExpanded = isExpanded
        }
        
        var body: some View {
            content()
        }
        
        func content() -> some View {
            VStack(alignment: .leading) {
                Button {
                    isExpanded.wrappedValue.toggle()
                } label: {
                    header
                }
                .buttonStyle(.plain)
                
                if isExpanded.wrappedValue {
                    cellContent
                }
            }
        }
    }
}
