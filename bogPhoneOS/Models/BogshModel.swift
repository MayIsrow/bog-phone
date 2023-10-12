//
//  BogshModel.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI
import Foundation

enum BogshAppType: String, Decodable, Encodable {
    case console
    case smiley
    case frog
    case hole
}

struct BogshModel: Decodable {

    var app: BogshAppType = .console {
        didSet {
            saveAppToUserDefaults()
        }
    }
    var lines: [BogshLineModel] = [] {
        didSet {
            saveLinesToUserDefaults()
        }
    }
    
    func saveLinesToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(lines)
            UserDefaults.standard.set(encodedData, forKey: "savedLines")
        } catch {
            print("Error saving lines to UserDefaults: \(error)")
        }
    }
    
    func saveAppToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(app)
            UserDefaults.standard.set(encodedData, forKey: "app")
        } catch {
            print("Error saving app to UserDefaults: \(error)")
        }
    }
    
    mutating func loadDataFromUserDefaults() {
        if let savedData = UserDefaults.standard.data(forKey: "savedLines") {
            do {
                lines = try JSONDecoder().decode([BogshLineModel].self, from: savedData)
            } catch {
                print("Error loading lines from UserDefaults: \(error)")
            }
        }
        
        if let savedData = UserDefaults.standard.data(forKey: "app") {
            do {
                app = try JSONDecoder().decode(BogshAppType.self, from: savedData)
            } catch {
                print("Error loading app from UserDefaults: \(error)")
            }
        }
    }
}

#Preview {
    BogshView()
}
