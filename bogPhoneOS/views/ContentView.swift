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
        BogshView(bogsh)
    }
}

#Preview {
    ContentView()
}
