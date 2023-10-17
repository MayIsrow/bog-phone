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
        NavigationStack {
            VStack {
                Text("bogPhoneOS")
                    .modifier(MinimalModifier(.title3))
                    .foregroundStyle(Color(BogshColorType.accent.rawValue))
                
                Spacer()
                
                if users.isEmpty {
                    HStack {
                        Text("Creating guest user")
                            .padding()
                        ProgressView()
                    }
                    .onAppear {
                        modelContext.insert(User(preferences: Preferences(name: "guest", emoji: "🐸")))
                    }
                } else {
                    HStack {
                        ForEach(users) { user in
                            if let firstSession = user.sessions.first{
                                NavigationLink {
                                    SessionView(sessionController: SessionController(session: firstSession, preferences: user.preferences))
                                } label: {
                                    VStack {
                                        Text(user.preferences.emoji)
                                        Text(user.preferences.name)
                                            .foregroundStyle(Color(user.preferences.color.rawValue))
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(user.preferences.color.rawValue), lineWidth: 2))
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }

    }
}

#Preview {
    LockScreen()
        .modelContainer(for: User.self, inMemory: true)
}
