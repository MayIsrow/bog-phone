//
//  BogshModels.swift
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
            let encodedData = try JSONEncoder().encode(app.rawValue)
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

struct BogshLineModel: Identifiable, Decodable, Encodable, Hashable {
    private(set) var id = UUID()
    var text: String
    //var textStyle: Font.TextStyle
    //var design: Font.Design
    var colorString: String
    
    init(_ text: String, colorString: String) {
        self.text = text
        self.colorString = colorString
    }
}

#Preview {
    BogshView()
}
