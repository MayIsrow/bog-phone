//
//  Preferences.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation
import SwiftData

@Model final class Preferences {
    var name: String
    var color: BogshColorType
    
    init(name: String, color: BogshColorType = .accent) {
        self.name = name
        self.color = color
    }
}
