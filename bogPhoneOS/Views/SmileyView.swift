//
//  SmileBogshApp.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI

struct SmileyView: View {
    var body: some View {
        ZStack {
            Image(systemName: "smiley")
                .resizable()
                .modifier(MinimalModifier(.largeTitle))
                .padding()
        }
    }
}

#Preview {
    SmileyView()
}
