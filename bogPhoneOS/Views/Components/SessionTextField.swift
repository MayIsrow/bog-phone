//
//  SessionTextField.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI

struct SessionTextField: View {
    @State var placeHolderText: String
    @Binding var text: String
    @ObservedObject var sessionController: SessionController
    @State var onCommit: () -> Void

    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Button(action: action, label: {
                HStack {
                    if !placeHolderText.isEmpty {
                        Text(placeHolderText)
                            .modifier(MinimalModifier())
                            .padding([.leading, .vertical], 10)
                    }
                    
                    Image(systemName: "chevron.right")
                        .padding(buttonPadding, 10)
                }})
            .buttonStyle(MinimalButtonStyle())
            
            TextField("", text: $text)
                .textFieldStyle(MinimalTextFieldStyle())
                .focused($isFocused)
            
            Button(action: action, label: {
                if !sessionController.session.isResponding {
                    Image(systemName: "forward.frame.fill")
                } else {
                    ProgressView()
                }})
            .buttonStyle(MinimalButtonStyle())
            .padding([.trailing, .vertical], 10)
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(sessionController.preferences.color.rawValue), lineWidth: 2))
    }
    
    private var buttonPadding:Edge.Set.ArrayLiteralElement {
        !placeHolderText.isEmpty ? [.vertical] : [.leading, .vertical]
    }
    
    private func action() {
        if !sessionController.session.isResponding {
            onCommit()
        }
    }
}

/*
#Preview {
    SessionTextView()
}
*/
