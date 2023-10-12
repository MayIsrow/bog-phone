//
//  BogshLineModel.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/12/23.
//

import Foundation

struct BogshLineModel: Identifiable, Decodable, Encodable, Hashable {
    private(set) var id = UUID()
    var text: String
    var colorString: String
    
    init(_ text: String, colorString: String) {
        self.text = text
        self.colorString = colorString
    }
}
