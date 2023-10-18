//
//  Console.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import SwiftData
import AVFAudio

@Model final class Console {
    
    var id = UUID()
    
    var consoleLines: [ConsoleLine] = []
    
    var state: ConsoleStateType
    
    @Transient
    var isResponding = false
    
    init(openView: ConsoleStateType = .console) {
        self.state = openView
    }
}
