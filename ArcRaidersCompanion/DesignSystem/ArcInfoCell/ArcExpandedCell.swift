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
            VStack(alignment: .leading, spacing: 0) {
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

    // MARK: - Пример использования
    struct ArcInfoCellTest: View {
        @State private var isExpanded1 = false
        @State private var isExpanded2 = false
        @State private var isExpanded3 = false
        
        var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                    // Пример 1: Простой список
                    ArcExpandedCell(isExpanded: $isExpanded1) {
                        HStack {
                            Image(systemName: "folder")
                                .foregroundColor(.blue)
                            Text("Мои проекты")
                                .font(.headline)
                            Spacer()
                            Image(systemName: isExpanded1 ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    } content: {
                        VStack(alignment: .leading, spacing: 12) {
                            ExpandableRow(icon: "doc", title: "Проект 1")
                            ExpandableRow(icon: "doc", title: "Проект 2")
                            ExpandableRow(icon: "doc", title: "Проект 3")
                        }
                        .padding(.leading)
                        .padding(.top, 8)
                    }
                    
                    // Пример 2: С пользовательским контентом
                    ArcExpandedCell(isExpanded: $isExpanded2) {
                        HStack {
                            Image(systemName: "person.circle")
                                .foregroundColor(.green)
                            Text("Пользователи")
                                .font(.headline)
                            Spacer()
                            Text("5 новых")
                                .font(.caption)
                                .foregroundColor(.red)
                            Image(systemName: isExpanded2 ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    } content: {
                        VStack(spacing: 10) {
                            UserRow(name: "Анна", status: "Онлайн")
                            UserRow(name: "Михаил", status: "Офлайн")
                            UserRow(name: "Екатерина", status: "Онлайн")
                        }
                        .padding(.top, 8)
                    }
                    
                    // Пример 3: Вложенные раскрывающиеся блоки
                    ArcExpandedCell(isExpanded: $isExpanded3) {
                        HStack {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.purple)
                            Text("Категории")
                                .font(.headline)
                            Spacer()
                            Image(systemName: isExpanded3 ? "chevron.up" : "chevron.down")
                        }
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(10)
                    } content: {
                        VStack(alignment: .leading, spacing: 8) {
                            NestedExpandableSection(title: "iOS разработка", items: ["Swift", "SwiftUI", "UIKit"])
                            NestedExpandableSection(title: "Android разработка", items: ["Kotlin", "Java", "Compose"])
                            NestedExpandableSection(title: "Backend", items: ["Python", "Node.js", "Go"])
                        }
                        .padding(.leading)
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
        }
    }

    struct ExpandableRow: View {
        let icon: String
        let title: String
        
        var body: some View {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 24)
                Text(title)
                    .font(.body)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
    }

    struct UserRow: View {
        let name: String
        let status: String
        
        var body: some View {
            HStack {
                Circle()
                    .fill(status == "Онлайн" ? Color.green : Color.gray)
                    .frame(width: 8, height: 8)
                Text(name)
                    .font(.body)
                Spacer()
                Text(status)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
    }

    struct NestedExpandableSection: View {
        let title: String
        let items: [String]
        @State private var isExpanded = false
        
        var body: some View {
            ArcExpandedCell(isExpanded: $isExpanded) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                }
                .padding(.vertical, 6)
            } content: {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(items, id: \.self) { item in
                        Text("• \(item)")
                            .font(.caption)
                            .padding(.leading)
                    }
                }
                .padding(.bottom, 4)
            }
        }
    }

    // MARK: - Альтернативная версия с кастомным стилем
    struct CustomExpandableCard<Content: View>: View {
        let title: String
        let icon: String
        @Binding var isExpanded: Bool
        let content: Content
        
        init(title: String,
             icon: String,
             isExpanded: Binding<Bool>,
             @ViewBuilder content: () -> Content) {
            self.title = title
            self.icon = icon
            self._isExpanded = isExpanded
            self.content = content()
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: icon)
                            .foregroundColor(.accentColor)
                            .frame(width: 30)
                        
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .rotationEffect(.degrees(isExpanded ? 90 : 0))
                            .animation(.easeInOut(duration: 0.25), value: isExpanded)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                if isExpanded {
                    content
                        .padding(.top, 8)
                        .padding(.horizontal, 4)
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .top)),
                            removal: .opacity.combined(with: .move(edge: .top))
                        ))
                }
            }
        }
    }
}
