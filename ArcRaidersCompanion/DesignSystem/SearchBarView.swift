//
//  SearchBarView.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 11.04.2026.
//

import SwiftUI

extension Views {
    struct SearchTextView: View {
        @Binding private var searchText: String
        @Binding private var scrollOffset: CGFloat
        @Binding var isFocused: Bool
        @State private var debounceTask: Task<Void, Never>?
        let onTextChange: (String) -> Void
        
        init(searchText: Binding<String>,
             scrollOffset: Binding<CGFloat>,
             isFocus: Binding<Bool>,
             onTextChange: @escaping (String) -> Void
        ) {
            self._searchText = searchText
            self._scrollOffset = scrollOffset
            self._isFocused = isFocus
            self.onTextChange = onTextChange
        }
        
        var body: some View {
            content()
                .onChange(of: searchText) { newValue in
                    if !newValue.isEmpty {
                        logicWhenUserWriteSome(with: newValue)
                    }
                }
        }
    }
}

extension Views.SearchTextView {
    func logicWhenUserWriteSome(with value: String) {
        debounceTask?.cancel()
        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            if !Task.isCancelled {
                await MainActor.run {
                    onTextChange(value)
                }
            }
        }
    }
}

extension Views.SearchTextView {
    func content() -> some View {
        searchBarView()
        .padding(10)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
    
    func searchBarView() -> some View {
        HStack {
            if isFocused {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
            }
            
            CustomTextField(
                text: $searchText,
                isFocused: $isFocused,
                placeholder: "Search item ..."
            )
        }
    }
    
    @ViewBuilder
    func searchBarImage(isChoised: Binding<Bool>) -> some View {
        if isChoised.wrappedValue {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
        } else {
            EmptyView()
        }
    }
}

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
    let placeholder: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.delegate = context.coordinator
        textField.returnKeyType = .done // Для возможности скрыть клавиатуру кнопкой
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        
        // ✅ Исправленная логика: гарантируем выполнение в правильный момент
        DispatchQueue.main.async {
            if isFocused {
                if !uiView.isFirstResponder {
                    uiView.becomeFirstResponder()
                }
            } else {
                if uiView.isFirstResponder {
                    uiView.resignFirstResponder()
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isFocused: $isFocused)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocused: Bool
        
        init(text: Binding<String>, isFocused: Binding<Bool>) {
            self._text = text
            self._isFocused = isFocused
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        // ✅ Более надёжный метод для отслеживания изменений текста
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentText = textField.text,
               let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                DispatchQueue.main.async {
                    self.text = updatedText
                }
            }
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFocused = true
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFocused = false
            }
        }
        
        // ✅ Скрытие клавиатуры по нажатию Return
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}

func hideKeyboard() {
    UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil,
        from: nil,
        for: nil
    )
}
