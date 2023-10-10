//
//  BogshController.swift
//  Cyberpunk Terminal
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

enum BogshApp {
    case none
    case bogsh
    case smiley
}

class BogshController: ObservableObject, Equatable {
    @Published private(set) var lines: [BogshTextModel] = []
    @Published private(set) var isResponding = false
    @Published private(set) var app: BogshApp = .none
    
    private let parent: BogshController?
    
    init(parent: BogshController? = nil) {
        self.parent = parent
        
        lines.append(BogshTextModel("welcome to the bog :)", color: Color("bogsh")))
    }
    
    func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !isResponding, !newInput.isEmpty else {
            return
        }
        
        let newLine = BogshTextModel("\(newInput)", color: Color("accent"))
        lines.append(newLine)
        
        isResponding = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.respond(newInput)
            self.isResponding = false
        }
    }
    
    func closeApp() {
        app = .none
        lines.append(BogshTextModel("welcome back to the bog", color: Color("bogsh")))
    }
    
    private func respond(_ input: String = "") {
        switch input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "hello":
            lines.append(BogshTextModel("hiiii", color: Color("bogsh")))
        case "clear":
            lines = [BogshTextModel("", color: Color("bogsh"))]
        case "boggers":
            lines.append(BogshTextModel("BogChamp :o", color: Color("bogsh")))
        case "logout":
            lines.append(BogshTextModel("logout? try bogout, idiot", color: Color("bogsh")))
        case "bogout":
            lines.append(BogshTextModel("no.", color: Color("bogsh")))
        case ":(":
            lines.append(BogshTextModel("im sorry :(", color: Color("bogsh")))
        case "bogsh":
            lines.append(BogshTextModel("Opening new bogsh window", color: Color("bogsh")))
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.app = .bogsh
            }
        case "smiley":
            lines.append(BogshTextModel("😀", color: Color("bogsh")))
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.app = .smiley
            }
        case "exit":
            if parent != nil {
                lines.append(BogshTextModel("Closing bogsh child", color: Color("bogsh")))
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    self.parent?.closeApp()
                }
            } else {
                lines.append(BogshTextModel("exiting", color: Color("bogsh")))
                lines = []
            }
        case "help":
            lines.append(BogshTextModel("""
                
                Help Menu:
                help - displays this message
                clear - clears the screen
                bogsh - opens a new bogsh window
                exit - exits the current bogsh window
                logout - calls you an idiot
                smiley - opens the smiley app
                ...and others???
                """, color: Color("bogsh")))
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
