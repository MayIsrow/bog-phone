//
//  ConsoleController.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import AVFAudio

class SessionController: ObservableObject {
    
    @Published var session: Session
    
    @Published var preferences: Preferences
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    init(session: Session, preferences: Preferences) {
        self.session = session
        self.preferences = preferences
    }
    
    func push(_ input: String) {
        if session.isResponding {
            return
        }
        
        let newInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        write(newInput, color: preferences.color)
        
        session.isResponding = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.respond(newInput)
            self.session.isResponding = false
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
            "help": handleHelpCommand,
            "stop": handleStopCommand,
            "🌈": handleRainbowCommand,
            "🏳️‍🌈": handleRainbowCommand,
            "🏳️‍⚧️": handleTransCommand,
            "speak": handleSpeakCommand
        ]
        
        if let commandFunction = commandMap[command] {
            commandFunction(parameters)
        } else {
            write("Command not found: \(formattedInput)", color: .bogsh)
        }
    }
    
    // MARK: - Helper Functions
    
    private func write(_ text: String, color: BogshColorType = .bogsh) {
        session.consoleLines.append(ConsoleLine(text: text, color: color))
    }
    
    private func refresh() {
        session.isVisible = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.session.isVisible = true
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
        session.state = .smiley
    }
    
    private func handleKillCommand(_ parameters: [String]) {
        session.consoleLines = []
        session.state = .console
    }
    
    private func handleExitCommand(_ parameters: [String]) {
        session.state = .console
    }
    
    private func handleReactorCommand(_ parameters: [String]) {
        write("I'm so freaking reactor pilled brother", color: .green)
    }
    
    private func handleFrogCommand(_ parameters: [String]) {
        write("🐸")
        session.state = .frog
    }
    
    private func handleBilboCommand(_ parameters: [String]) {
        write("What about second breakfast?", color: .red)
    }
    
    private func handleHideCommand(_ parameters: [String]) {
        session.state = .hole
    }
    
    private func handleRelaxCommand(_ parameters: [String]) {
        write("No problem, I've got some chill tunes for ya, champ.")
        GSAudio.sharedInstance.playSound(soundFileName: "elevator-music.wav")
    }
    
    private func handleHelpCommand(_ parameters: [String]) {
        write("""
            Help Menu:
            help - displays this message
            clear - clears the screen
            exit - exits the current bogsh window
            logout - calls you an idiot
            smiley - opens the smiley app
            frog - opens the frog app
            hide - go to a safe place :)
            relax - helps keep you calm!
            color list - see a list of selectable colors
            speak - make one of the little guys in your phone say something
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
            preferences.color = .red
            refresh()
        case "orange":
            preferences.color = .orange
            refresh()
        case "yellow":
            preferences.color = .yellow
            refresh()
        case "green":
            preferences.color = .green
            refresh()
        case "blue":
            preferences.color = .blue
            refresh()
        case "indigo":
            preferences.color = .indigo
            refresh()
        case "violet":
            preferences.color = .violet
            refresh()
        case "pink":
            preferences.color = .pink
            refresh()
        
        case "default":
            fallthrough
        case "reset":
            preferences.color = .accent
            refresh()
        default:
            write("Color not found: \(parameters[0])")}
    }
    
    private func handleStopCommand(_ parameters: [String]) {
        GSAudio.sharedInstance.stopAllSounds()
    }
    
    private func handleRainbowCommand(_ parameters: [String]) {
        respond("color list")
    }
            
    private func handleTransCommand(_ parameters: [String]) {
        respond("trans rights")
    }
    
    private func handleSpeakCommand(_ parameters: [String]) {
        if parameters.count == 0 {
            write("Expected parameter. Ex: 'speak Hello World!'")
            return
        }
        
        if parameters[0] == "help" {
            write("Go ahead. Type 'speak' followed with what you want one of the little guys living inside of your phone to say. Tap the example to copy it to your console:")
            write("speak hello world!")
        } else {
            var sentence = ""
            
            for word in parameters {
                sentence += "\(word) "
            }
            
            
            let utterance = AVSpeechUtterance(string: sentence)
            
            utterance.pitchMultiplier = Float.random(in: 0.1...0.75)
            utterance.rate = Float.random(in: 0.1...0.75)
            utterance.volume = 0.35
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            if !speechSynthesizer.isSpeaking  {
                write("One of the tiny little bog guys living inside of your phone says \"\(sentence)\"")
                speechSynthesizer.speak(utterance)
            }
        }
    }
}
