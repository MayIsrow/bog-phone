//
//  BogshController.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

class BogshController: ObservableObject, Equatable {
    @Published private(set) var lines: [BogshTextModel] = []
    @Published private(set) var isResponding = false
    
    func push(_ input: String) {
        guard !isResponding, !input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        let newLine = BogshTextModel("\(input)", color: Color("accent"))
        lines.append(newLine)
        
        isResponding = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.respond(input)
            self.isResponding = false
        }
    }
    
    private func respond(_ input: String = "") {
        switch input.lowercased() {
        case "hello":
            lines.append(BogshTextModel("hiiii", color: Color("bogsh")))
        case "clear":
            lines = [BogshTextModel("", color: Color("bogsh"))]
        default:
            lines.append(BogshTextModel("Command not found: \(input)", color: Color("bogsh")))
        }
    }
    
    static func == (lhs: BogshController, rhs: BogshController) -> Bool {
        return lhs.lines == rhs.lines
    }
}

struct BogshTextModel: Hashable, Identifiable {
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
    
    init(_ BogshTextModel: BogshTextModel) {
        self.text = BogshTextModel.text
        self.textStyle = BogshTextModel.textStyle
        self.design = BogshTextModel.design
        self.color = BogshTextModel.color
    }
    
    // a function that returns this model as some View
    func asView() -> some View {
        return Text(text)
            .minimal()
    }
}
