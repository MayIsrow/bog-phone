//
//  ContentView.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bogsh = BogshController()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "microbe.circle")
                    .minimal(.largeTitle, color: Color("accent"))
                
                Text("bogPhoneOS")
                    .minimal(.largeTitle, color: Color("accent"))
            }
            
            NavigationStack {
                BogshView(bogsh)
            }
        }
    }
}

#Preview {
    ContentView()
}
