//
//  extensions.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import Foundation


// the two extensions below were copied from https://stackoverflow.com/a/66398629 courtesy of Raja Kishan
extension String {
    func onlyEmoji() -> String {
        return self.filter({$0.isEmoji})
    }
}

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
