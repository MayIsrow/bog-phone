//
//  MinimalModifier.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

struct MinimalModifier: ViewModifier {
    @State var textStyle: Font.TextStyle
    @State var design: Font.Design
    @State var color: Color
    
    init(_ textStyle: Font.TextStyle = .body, design: Font.Design = .monospaced, color: Color = .primary) {
        self._textStyle = State(initialValue: textStyle)
        self._design = State(initialValue: design)
        self._color = State(initialValue: color)
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(textStyle, design: design))
            .foregroundStyle(color)
            .tint(color)
            .accentColor(color)
    }
}

extension View {
    func minimal(_ textStyle: Font.TextStyle = .body, design: Font.Design = .monospaced, color: Color = .primary) -> some View {
        self.modifier(MinimalModifier(textStyle, design: design, color: color))
    }
}
