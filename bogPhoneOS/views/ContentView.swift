//
//  ContentView.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "microbe.circle")
                    .minimal(.title2, color: Color("accent"))
                
                Text("bogPhoneOS")
                    .minimal(.title2, color: Color("accent"))
            }
            
            BogshView(bogsh: BogshModel(parent: BogshModels()))
        }
        
    }
}

#Preview {
    ContentView()
}
