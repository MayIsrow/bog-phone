//
//  BogshController.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import Foundation

class BogshController: ObservableObject {
    @Published var model: BogshModel
    
    init() {
        model = BogshModel()
    }
}
