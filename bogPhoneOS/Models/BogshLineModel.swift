//
//  BogshLineModel.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/12/23.
//

import Foundation

struct BogshLineModel: Identifiable, Codable, Hashable {
    private(set) var id = UUID()
    var text: String
    var color: BogshColorType
    
    init(_ text: String, color: BogshColorType) {
        self.text = text
        self.color = color
    }
}
