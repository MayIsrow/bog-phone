//
//  BogshModels.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI

enum BogshAppType {
    case console
    case smiley
    case frog
    case hole
}

struct BogshModel: Hashable, Identifiable {
    private(set) var id = UUID()
    var app: BogshAppType = .console
    var lines: [BogshLineModel] = []
    
    static func == (lhs: BogshModel, rhs: BogshModel) -> Bool {
        return lhs.lines == rhs.lines
    }
}

struct BogshLineModel: Hashable, Identifiable {
    private(set) var id = UUID()
    var text: String
    var textStyle: Font.TextStyle
    var design: Font.Design
    var color: Color
    
    init(_ text: String, textStyle: Font.TextStyle = .body, design: Font.Design = .default, color: Color = .primary) {
        self.text = text
        self.textStyle = textStyle
        self.design = design
        self.color = color
    }
    
    init(_ BogshTextModel: BogshLineModel) {
        self.text = BogshTextModel.text
        self.textStyle = BogshTextModel.textStyle
        self.design = BogshTextModel.design
        self.color = BogshTextModel.color
    }
}

#Preview {
    BogshView()
}
