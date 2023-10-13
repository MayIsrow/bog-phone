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
        let formattedInput = input.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let components = formattedInput.components(separatedBy: " ")
        let command = components[0]
        let parameters = Array(components.dropFirst())
        
        // Define a dictionary to map commands to their corresponding functions
        let commandMap: [String: ([String]) -> Void] = [
            "": handleEmptyCommand,
            "hello": handleHelloCommand,
            "hi": handleHiCommand,
            "huh": handleHuhCommand,
            "what": handleWhatCommand,
            "clear": handleClearCommand,
            "boggers": handleBoggersCommand,
            "bogchamp": handleBoggersCommand,
            "logout": handleLogoutCommand,
            "bogout": handleBogoutCommand,
            ":(": handleSadCommand,
            "bogsh": handleBogshCommand,
            ":)": handleSmileyCommand,
            "🙂": handleSmileyCommand,
            "smiley": handleSmileyCommand,
            "kill": handleKillCommand,
            "exit": handleExitCommand,
            "reactor": handleReactorCommand,
            "silo": handleReactorCommand,
            "frog": handleFrogCommand,
            "bog": handleFrogCommand,
            "🐸": handleFrogCommand,
            "bilboboggins": handleBilboCommand,
            "hole": handleHideCommand,
            "hide": handleHideCommand,
            "relax": handleRelaxCommand,
            "help": handleHelpCommand
        ]
        
        if let commandFunction = commandMap[command] {
            commandFunction(parameters)
        } else {
            write("Command not found: \(formattedInput)", color: .bogsh)
        }
    }
    
    // MARK: - Helper Functions
    
    private func write(_ text: String, color: BogshColorType) {
        self.model.lines.append(BogshLineModel(text, color: color))
    }
    
    
    // MARK: - Command Handlers
    
    private func handleEmptyCommand(_ parameters: [String]) {
        write("", color: .bogsh)
    }
    
    private func handleHelloCommand(_ parameters: [String]) {
        write("hiiii", color: .bogsh)
    }
    
    private func handleHiCommand(_ parameters: [String]) {
        write("hello", color: .bogsh)
    }
    
    private func handleHuhCommand(_ parameters: [String]) {
        write("what?", color: .bogsh)
    }
    
    private func handleWhatCommand(_ parameters: [String]) {
        write("huh?", color: .bogsh)
    }
    
    private func handleClearCommand(_ parameters: [String]) {
        write("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", color: .bogsh)
        write("", color: .bogsh)
    }
    
    private func handleBoggersCommand(_ parameters: [String]) {
        write("BogChamp 😲", color: .bogsh)
    }
    
    private func handleLogoutCommand(_ parameters: [String]) {
        write("logout? try bogout, idiot", color: .bogsh)
    }
    
    private func handleBogoutCommand(_ parameters: [String]) {
        write("no.", color: .bogsh)
    }
    
    private func handleSadCommand(_ parameters: [String]) {
        write("im sorry :(", color: .bogsh)
    }
    
    private func handleBogshCommand(_ parameters: [String]) {
        write("Coming soon!", color: .bogsh)
    }
    
    private func handleSmileyCommand(_ parameters: [String]) {
        model.app = .smiley
    }
    
    private func handleKillCommand(_ parameters: [String]) {
        model.lines = []
        model.app = .console
    }
    
    private func handleExitCommand(_ parameters: [String]) {
        model.app = .console
    }
    
    private func handleReactorCommand(_ parameters: [String]) {
        write("I'm so freaking reactor pilled brother", color: .bogsh)
    }
    
    private func handleFrogCommand(_ parameters: [String]) {
        write("🐸", color: .bogsh)
        model.app = .frog
    }
    
    private func handleBilboCommand(_ parameters: [String]) {
        write("What about second breakfast?", color: .bogsh)
    }
    
    private func handleHideCommand(_ parameters: [String]) {
        model.app = .hole
    }
    
    private func handleRelaxCommand(_ parameters: [String]) {
        write("No problem, I've got some chill tunes for ya champ.", color: .bogsh)
        GSAudio.sharedInstance.playSound(soundFileName: "elevator-music.wav")
    }
    
    private func handleHelpCommand(_ parameters: [String]) {
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
    }
}
