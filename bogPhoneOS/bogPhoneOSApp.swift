//
//  bogPhoneOSApp.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

@main
struct bogPhoneOSApp: App {
    var body: some Scene {
        WindowGroup {
            LockScreen()
        }
        .modelContainer(for: User.self)
    }
}
