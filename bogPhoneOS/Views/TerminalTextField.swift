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
    @ObservedObject var bogsh: BogshController
    @State var onCommit: () -> Void

    @FocusState private var isFocused: Bool
    
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
                if !bogsh.isResponding {
                    Image(systemName: "forward.frame.fill")
                } else {
                    ProgressView()
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
        onCommit()
        isFocused = true
    }
}

#Preview {
    TerminalTextField(placeHolderText: "placeholder", text: .constant(""), color: Color("accent"), bogsh: BogshController()) {
        print("Hello World!")
    }
    .padding()
}

