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
        model.loadDataFromUserDefaults()
    }
    
    func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        write(newInput, color: .accent)
        
        isResponding = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.respond(newInput)
            self.isResponding = false
        }
    }
    
    private func respond(_ input: String = "") {
        let formattedInput = input.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch formattedInput {
        case " ":
            fallthrough
        case "":
            write("", color: .bogsh)
        case "hello":
            write("hiiii", color: .bogsh)
        case "hi":
            write("hello", color: .bogsh)
        case "huh":
            write("what?", color: .bogsh)
        case "what":
            write("huh?", color: .bogsh)
        case "clear":
            //model.lines = []
            write("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", color: .bogsh)
            write("", color: .bogsh)
        case "boggers":
            fallthrough
        case "bogchamp":
            write("BogChamp 😲", color: .bogsh)
        case "logout":
            write("logout? try bogout, idiot", color: .bogsh)
        case "bogout":
            write("no.", color: .bogsh)
        case ":(":
            write("im sorry :(", color: .bogsh)
        case "bogsh":
            write("Coming soon!", color: .bogsh)
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
            write("I'm so freaking reactor pilled brother", color: .bogsh)
        case "frog":
            fallthrough
        case "bog":
            fallthrough
        case "🐸":
            write("🐸", color: .bogsh)
            model.app = .frog
        case "bilbo boggins":
            write("What about second breakfast?", color: .bogsh)
        case "hole":
            fallthrough
        case "hide":
            model.app = .hole
        case "relax":
            write("No problem, I've got some chill tunes for ya champ.", color: .bogsh)
            GSAudio.sharedInstance.playSound(soundFileName: "elevator-music.wav")
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
                relax - helps keep you calm!
                ...and others???
                """, color: .bogsh)
        default:
            write("Command not found: \(input)", color: .bogsh)
        }
    }
    
    private func write(_ text: String, color: BogshColorType) {
        self.model.lines.append(BogshLineModel(text, color: color))
    }
}

#Preview {
    BogshView()
}
