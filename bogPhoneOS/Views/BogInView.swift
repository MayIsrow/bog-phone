//
//  LockScreen.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI
import SwiftData

struct BogInView: View {
    
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
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 110))
                    ]) {
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
                                    .frame(width: 100, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(user.preferences.color.rawValue), lineWidth: 2))
                                    
                                }
                            }
                        }
                        
                        NavigationLink {
                            UserCreationView { name, emoji in
                                modelContext.insert(User(preferences: Preferences(name: name, emoji: emoji)))
                            }
                        } label: {
                            VStack {
                                Image(systemName: "plus")
                                    .padding(2)
                                Text("Add User")
                            }
                            .foregroundStyle(Color(BogshColorType.accent.rawValue))
                            .frame(width: 100, height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(BogshColorType.accent.rawValue), lineWidth: 2))
                        }
                    }
                }
                Spacer()
            }
        }
        
    }
}

#Preview {
    BogInView()
        .modelContainer(for: User.self, inMemory: true)
}
