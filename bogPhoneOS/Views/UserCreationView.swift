//
//  UserCreationView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI
import UIKit

struct UserCreationView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var name = ""
    
    @State var emoji = ""
    
    var onSubmit: (_ name: String, _ emoji: String) -> Void
    
    var body: some View {
        
        VStack {
            VStack {
                TextField("name", text: $name)
                
                Divider()
                
                TextField("emoji", text: $emoji)
                    .onChange(of: $emoji.wrappedValue) {
                        emoji = String($0.onlyEmoji().prefix(1))
                    }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(BogshColorType.accent.rawValue), lineWidth: 2))
            .padding()
            
            Text("submit")
                .modifier(MinimalModifier())
                .padding()
                .onTapGesture {
                    onSubmit(name, emoji)
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .navigationBarBackButtonHidden()
        .foregroundStyle(Color(BogshColorType.accent.rawValue))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("user creation")
                    .modifier(MinimalModifier(.title2))
                    .foregroundStyle(Color(BogshColorType.accent.rawValue))
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Text("exit")
                    .modifier(MinimalModifier())
                    .foregroundStyle(Color(BogshColorType.red.rawValue))
                    .padding()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        
    }
}

#Preview {
    UserCreationView {_,_ in 
        
    }
}
