//
//  BogshController.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI

class BogshController: ObservableObject {
    @Published var model: BogshModel
    @Published var isResponding = false
    
    init() {
        model = BogshModel()
    }
    
    func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        //write(newInput, color: Color("accent"))
        model.lines.append(BogshLineModel(newInput, color: Color("accent")))
        self.respond(newInput)
    }
    
    private func respond(_ input: String = "") {
        let formattedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch formattedInput {
        case " ":
            fallthrough
        case "":
            write("", color: Color("bogsh"))
        case "hello":
            write("hiiii", color: Color("bogsh"))
        case "hi":
            write("hello", color: Color("bogsh"))
        case "huh":
            write("what?", color: Color("bogsh"))
        case "what":
            write("huh?", color: Color("bogsh"))
        case "clear":
            model.lines = []
            write("", color: Color("bogsh"))
        case "boggers":
            fallthrough
        case "bogchamp":
            write("BogChamp 😲", color: Color("bogsh"))
        case "logout":
            write("logout? try bogout, idiot", color: Color("bogsh"))
        case "bogout":
            write("no.", color: Color("bogsh"))
        case ":(":
            write("im sorry :(", color: Color("bogsh"))
        case "bogsh":
            write("Coming soon!", color: Color("bogsh"))
            //parent.bogshs.append(BogshModel(parent: parent))
        case ":)":
            fallthrough
        case "🙂":
            fallthrough
        case "smiley":
            model.app = .smiley
        case "kill":
            model.app = .console
            fallthrough
        case "exit":
            if model.app != .console {
                model.app = .console
            } else {
                model.lines = []
            }
        case "reactor":
            fallthrough
        case "silo":
            write("I'm so freaking reactor pilled brother", color: Color("bogsh"))
        case "frog":
            fallthrough
        case "bog":
            fallthrough
        case "🐸":
            write("🐸", color: .green)
            model.app = .frog
        case "bilbo boggins":
            write("What about second breakfast?", color: .red)
        case "hole":
            fallthrough
        case "hide":
            model.app = .hole
        case "help":
            write("""
                Help Menu:
                help - displays this message
                clear - clears the screen
                bogsh - opens a new bogsh window
                exit - exits the current bogsh window
                logout - calls you an idiot
                smiley - opens the smiley app
                frog - opens the frog app
                hide - go to a safe place :)
                ...and others???
                """, color: Color("bogsh"))
        default:
            write("Command not found: \(input)", color: Color("bogsh"))
        }
    }
    
    private func write(_ text: String, color: Color) {
        isResponding = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.model.lines.append(BogshLineModel(text, color: color))
            self.isResponding = false
        }
    }
}
