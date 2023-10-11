//
//  TerminalTextField.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/8/23.
//

import SwiftUI

struct TerminalTextField: View {
    @State var placeHolderText: String
    @Binding var text: String
    @State var color: Color
    @Binding var isInputEnabled: Bool
    @State var onCommit: () -> Void

    
    @FocusState private var isFocused: Bool
    
    init(_ placeHolderText: String = "", text: Binding<String>, accentColor: Color = .primary, isInputEnabled: Binding<Bool>,onCommit: @escaping () -> Void = {}) {
        self._placeHolderText = State(initialValue: placeHolderText)
        self._text = text
        self._color = State(initialValue: accentColor)
        self._isInputEnabled = isInputEnabled
        self._onCommit = State(initialValue: onCommit)
    }
    
    var body: some View {
        HStack {
            Button(action: action, label: {
                HStack {
                    if !placeHolderText.isEmpty {
                        Text(placeHolderText)
                            .modifier(MinimalModifier(color:color))
                            .padding([.leading, .vertical], 10)
                    }
                    
                    Image(systemName: "chevron.right")
                        .padding(buttonPadding, 10)
                }})
            .buttonStyle(MinimalButtonStyle(color: color))
            
            TextField("", text: $text)
                .textFieldStyle(MinimalTextFieldStyle(color: color))
                .focused($isFocused)
            
            Button(action: action, label: {
                if isInputEnabled {
                    Image(systemName: "forward.frame.fill")
                } else {
                    withAnimation {
                        ProgressView()
                    }
                }})
            .buttonStyle(MinimalButtonStyle(color: color))
            .padding([.trailing, .vertical], 10)
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(color, lineWidth: 2))
    }
    
    
    private var buttonPadding:Edge.Set.ArrayLiteralElement {
        !placeHolderText.isEmpty ? [.vertical] : [.leading, .vertical]
    }
    
    private func action() {
        if  text.replacingOccurrences(of: " ", with: "") != "" {
            onCommit()
            isFocused = true
        }
    }
}


#Preview {
    TerminalTextField("bogsh",text: .constant("Hello World!"), accentColor: Color("accent"), isInputEnabled: .constant(true)) {
        print("test")
    }
    .padding()
}

