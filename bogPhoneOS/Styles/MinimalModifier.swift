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
    
    init(_ textStyle: Font.TextStyle = .body, design: Font.Design = .monospaced) {
        self._textStyle = State(initialValue: textStyle)
        self._design = State(initialValue: design)
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(textStyle, design: design))
    }
}
