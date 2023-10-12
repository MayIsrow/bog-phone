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
    @Published var app: BogshAppType = .console
    
    init() {
        model = BogshModel()
        model.loadDataFromUserDefaults()
    }
    
    func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        //write(newInput, color: Color("accent"))
        model.lines.append(BogshLineModel(newInput, colorString: "accent"))
        
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
            write("", colorString: "bogsh")
        case "hello":
            write("hiiii", colorString: "bogsh")
        case "hi":
            write("hello", colorString: "bogsh")
        case "huh":
            write("what?", colorString: "bogsh")
        case "what":
            write("huh?", colorString: "bogsh")
        case "clear":
            //model.lines = []
            write("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", colorString: "bogsh")
            write("", colorString: "bogsh")
        case "boggers":
            fallthrough
        case "bogchamp":
            write("BogChamp 😲", colorString: "bogsh")
        case "logout":
            write("logout? try bogout, idiot", colorString: "bogsh")
        case "bogout":
            write("no.", colorString: "bogsh")
        case ":(":
            write("im sorry :(", colorString: "bogsh")
        case "bogsh":
            write("Coming soon!", colorString: "bogsh")
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
            write("I'm so freaking reactor pilled brother", colorString: "bogsh")
        case "frog":
            fallthrough
        case "bog":
            fallthrough
        case "🐸":
            write("🐸", colorString: "bogsh")
            model.app = .frog
        case "bilbo boggins":
            write("What about second breakfast?", colorString: "bogsh")
        case "hole":
            fallthrough
        case "hide":
            model.app = .hole
        case "relax":
            write("No problem, I've got some chill tunes for ya champ.", colorString: "bogsh")
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
                """, colorString: "bogsh")
        default:
            write("Command not found: \(input)", colorString: "bogsh")
        }
    }
    
    private func write(_ text: String, colorString: String) {
        self.model.lines.append(BogshLineModel(text, colorString: colorString))
    }
}
