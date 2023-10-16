//
//  Session.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import SwiftData

@Model final class Session {
    @Attribute(.unique) var id: UUID
    var consoleLines: [ConsoleLine]
    
    init(id: UUID = UUID(), consoleLines: [ConsoleLine] = []) {
        self.id = id
        self.consoleLines = consoleLines
    }
}
