//
//  LockScreen.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI
import SwiftData

struct LockScreen: View {
    
    @Query var users: [User]
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            if users.isEmpty {
                HStack {
                    Text("Creating guest user")
                        .padding()
                    ProgressView()
                }
                .onAppear {
                    modelContext.insert(User(preferences: Preferences(name: "guest")))
                }
            } else {
                if let user = users.first {
                    if let session = user.sessions.first {
                        SessionView(sessionController: SessionController(session: session, preferences: user.preferences))
                    }
                }
            }
            EmptyView()
        }
    }
}

#Preview {
    LockScreen()
        .modelContainer(for: User.self, inMemory: true)
}
