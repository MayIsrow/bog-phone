//
//  MinimalTextFieldStyle.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/8/23.
//

import SwiftUI

struct MinimalTextFieldStyle: TextFieldStyle {
    @State var color: Color = .primary
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .modifier(MinimalModifier(color: color))
            .background(.clear)
    }
}

#Preview {
    TextField("", text: .constant("Hello World!"))
        .textFieldStyle(MinimalTextFieldStyle())
}
