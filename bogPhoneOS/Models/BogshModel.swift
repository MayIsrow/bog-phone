//
//  BogshModel.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI
import Foundation

struct BogshModel {

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
    var userColor: BogshColorType = .accent {
        didSet {
            saveUserColorToUserDefaults()
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
    
    func saveUserColorToUserDefaults() {
        do {
            let encodedData = try JSONEncoder().encode(userColor)
            UserDefaults.standard.set(encodedData, forKey: "userColor")
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
        
        if let savedData = UserDefaults.standard.data(forKey: "userColor") {
            do {
                userColor = try JSONDecoder().decode(BogshColorType.self, from: savedData)
            } catch {
                print("Error loading app from UserDefaults: \(error)")
            }
        }
    }
}
