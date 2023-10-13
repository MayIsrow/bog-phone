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
    @Published var isVisible = true
    
    init() {
        model = BogshModel()
        model.loadDataFromUserDefaults()
    }
    
    func push(_ input: String) {
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        write(newInput, color: model.userColor)
        
        isResponding = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
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
            "color": handleColorCommand,
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
    
    private func write(_ text: String, color: BogshColorType = .bogsh) {
        self.model.lines.append(BogshLineModel(text, color: color))
    }
    
    private func refresh() {
        isVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
            self.isVisible = true
        }
    }
    
    // MARK: - Command Handlers
    
    private func handleEmptyCommand(_ parameters: [String]) {
        write("")
    }
    
    private func handleHelloCommand(_ parameters: [String]) {
        write("hiiii")
    }
    
    private func handleHiCommand(_ parameters: [String]) {
        write("hello")
    }
    
    private func handleHuhCommand(_ parameters: [String]) {
        write("what?")
    }
    
    private func handleWhatCommand(_ parameters: [String]) {
        write("huh?")
    }
    
    private func handleClearCommand(_ parameters: [String]) {
        write("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        write("")
    }
    
    private func handleBoggersCommand(_ parameters: [String]) {
        write("BogChamp 😲")
    }
    
    private func handleLogoutCommand(_ parameters: [String]) {
        write("logout? try bogout, idiot")
    }
    
    private func handleBogoutCommand(_ parameters: [String]) {
        write("no.")
    }
    
    private func handleSadCommand(_ parameters: [String]) {
        write("im sorry :(")
    }
    
    private func handleBogshCommand(_ parameters: [String]) {
        write("Coming soon!")
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
        write("I'm so freaking reactor pilled brother")
    }
    
    private func handleFrogCommand(_ parameters: [String]) {
        write("🐸")
        model.app = .frog
    }
    
    private func handleBilboCommand(_ parameters: [String]) {
        write("What about second breakfast?")
    }
    
    private func handleHideCommand(_ parameters: [String]) {
        model.app = .hole
    }
    
    private func handleRelaxCommand(_ parameters: [String]) {
        write("No problem, I've got some chill tunes for ya champ.")
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
            """)
    }
    
    private func handleColorCommand(_ parameters: [String]) {
        if parameters.count == 0 {
            write("Expected parameter. Ex: 'color red'. Type 'color list' for a list of available colors")
            return
        }
        
        switch(parameters[0]) {
        case "list":
            write("Listing color command options. Tap a command in the console to copy it!")
            write("color default", color: .accent)
            write("color red", color: .red)
            write("color orange", color: .orange)
            write("color yellow", color: .yellow)
            write("color green", color: .green)
            write("color blue", color: .blue)
            write("color indigo", color: .indigo)
            write("color violet", color: .violet)
            write("color pink", color: .pink)
            
            
        case "red":
            model.userColor = .red
            refresh()
        case "orange":
            model.userColor = .orange
            refresh()
        case "yellow":
            model.userColor = .yellow
            refresh()
        case "green":
            model.userColor = .green
            refresh()
        case "blue":
            model.userColor = .blue
            refresh()
        case "indigo":
            model.userColor = .indigo
            refresh()
        case "violet":
            model.userColor = .violet
            refresh()
        case "pink":
            model.userColor = .pink
            refresh()
        
        case "default":
            fallthrough
        case "reset":
            model.userColor = .accent
            refresh()
        default:
            write("Color not found: \(parameters[0])")}
    }
}
