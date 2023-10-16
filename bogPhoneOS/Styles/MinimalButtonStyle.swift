//
//  MinimalButtonStyle.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/8/23.
//

import SwiftUI

struct MinimalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(MinimalModifier(.headline))
    }
}

#Preview {
    Button(action: {}, label: {
        Text("Button")
            .font(.largeTitle)
    })
}
