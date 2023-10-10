//
//  SmileBogshApp.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI

struct SmileBogshApp: View {
    
    @ObservedObject var bogsh: BogshController = BogshController()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: close) {
                        Image(systemName: "xmark.circle")
                            
                    }
                    .minimal(.largeTitle, color: Color("accent"))
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            Image(systemName: "smiley")
                .minimal(.largeTitle, color: .yellow)
                .padding()
        }
        
    }
    
    private func close() {
        bogsh.closeApp()
    }
}

#Preview {
    SmileBogshApp()
}
