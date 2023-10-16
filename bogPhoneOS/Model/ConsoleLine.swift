//
//  ConsoleLine.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import SwiftData

@Model final class ConsoleLine {
    @Attribute(.unique) var id: UUID
    var text: String
    var color: BogshColorType
    var date: Date
    
    init(id: UUID = UUID(), text: String = "", color: BogshColorType = .accent, date: Date = Date()) {
        self.id = id
        self.text = text
        self.color = color
        self.date = date
    }
}
