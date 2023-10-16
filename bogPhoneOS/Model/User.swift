//
//  User.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftData
import Foundation

@Model final class User {
    @Attribute(.unique) var id = UUID()
    
    var preferences: Preferences
    
    var sessions: [Session] = []
    
    init(id: UUID = UUID(), preferences: Preferences, sessions: [Session]) {
        self.id = id
        self.preferences = preferences
        self.sessions = sessions
    }
}
