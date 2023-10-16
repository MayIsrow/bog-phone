//
//  Session.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import SwiftData
import AVFAudio

@Model final class Session {
    
    @Attribute(.unique) var id = UUID()
    
    var consoleLines: [ConsoleLine] = []
    
    var state: AppStateType
    
    @Transient
    var isResponding = false
    
    @Transient
    var isVisible = true
    
    init(openView: AppStateType = .console) {
        self.state = openView
    }
}
