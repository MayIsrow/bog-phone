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
}

struct BogshModels: Hashable, Identifiable {
    private(set) var id = UUID()
    var bogshs: [BogshModel] = []
    
    init() {
        bogshs.append(BogshModel(parent: self))
    }
}

struct BogshModel: Hashable, Identifiable {
    private(set) var id = UUID()
    private(set) var isResponding = false
    private(set) var app: BogshAppType = .console
    private(set) var lines: [BogshLineModel] = []
    let parent: BogshModels
    
    mutating func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !isResponding, !newInput.isEmpty else {
            return
        }
        
        write(newInput, color: Color("accent"))

        isResponding = true
        
        self.respond(newInput)
        self.isResponding = false
    }
    
    private mutating func respond(_ input: String = "") {
        let formattedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch formattedInput {
        case "hello":
            write("hiiii", color: Color("bogsh"))
        case "hi":
            write("hello", color: Color("bogsh"))
        case "huh":
            write("what?", color: Color("bogsh"))
        case "what":
            write("huh?", color: Color("bogsh"))
        case "clear":
            lines = []
            write("", color: Color("bogsh"))
        case "boggers":
            write("BogChamp 😲", color: Color("bogsh"))
        case "bogchamp":
            write("BogChamp 😲", color: Color("bogsh"))
        case "logout":
            write("logout? try bogout, idiot", color: Color("bogsh"))
        case "bogout":
            write("no.", color: Color("bogsh"))
        case ":(":
            write("im sorry :(", color: Color("bogsh"))
        case "bogsh":
            write("Opening new bogsh window", color: Color("bogsh"))
        case "smiley":
            write("😀", color: Color("bogsh"))
            app = .smiley
        case "exit":
            if app != .console {
                app = .console
            } else {
                lines = []
            }
        case "bilbo boggins":
            write("What about second breakfast?", color: .red)
        case "help":
            write("""
                
                Help Menu:
                help - displays this message
                clear - clears the screen
                bogsh - opens a new bogsh window
                exit - exits the current bogsh window
                logout - calls you an idiot
                smiley - opens the smiley app
                ...and others???
                """, color: Color("bogsh"))
            
        default:
            write("Command not found: \(input)", color: Color("bogsh"))
        }
    }
    
    private mutating func write(_ text: String, color: Color) {
        lines.append(BogshLineModel(text, color: color))
    }
    
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
    
    // a function that returns this model as some View
    func asView() -> some View {
        return Text(text)
            .minimal()
    }
}

#Preview {
    BogshView(bogsh: BogshModel(parent: BogshModels()))
}
