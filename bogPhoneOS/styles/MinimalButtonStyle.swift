//
//  MinimalButtonStyle.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/8/23.
//

import SwiftUI

struct MinimalButtonStyle: ButtonStyle {
    @State var color: Color = .primary
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .minimal(.headline, color: color)
    }
}

#Preview {
    Button(action: {}, label: {
        Text("Button")
            .font(.largeTitle)
    })
}
