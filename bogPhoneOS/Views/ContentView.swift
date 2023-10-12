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
                    .modifier(MinimalModifier(.title, color: Color("accent")))
                Text("bogPhoneOS")
                    .modifier(MinimalModifier(.title, color: Color("accent")))
            }
            BogshView()
        }
    }
}

#Preview {
    ContentView()
}
