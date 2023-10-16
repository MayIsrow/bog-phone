//
//  User.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftData
import Foundation

@Model final class User {
    @Attribute(.unique) var id: UUID
    
    var preferences: Preferences
    
    var sessions: [Session]
    
    init(preferences: Preferences) {
        self.id = UUID()
        self.preferences = preferences
        self.sessions = [Session()]
    }
}
