//
//  BogInView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI
import SwiftData

struct BogInView: View {
    
    @Query var users: [User]
    
    @Environment(\.modelContext) private var modelContext
    
    @State var isEditing = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if users.isEmpty {
                    HStack {
                        Text("Creating guest user")
                            .padding()
                        ProgressView()
                    }
                    .onAppear {
                        modelContext.insert(User(preferences: Preferences(name: "guest", emoji: "🐸", color: .green)))
                    }
                } else {
                    Spacer()
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 110))
                    ]) {
                        ForEach(users) { user in
                            ZStack {
                                NavigationLink {
                                    HomeView(user: user)
                                } label: {
                                    VStack {
                                        Text(user.preferences.emoji)
                                        Text(user.preferences.name)
                                            .foregroundStyle(Color(user.preferences.color.rawValue))
                                            .modifier(MinimalModifier(.headline))
                                    }
                                    .frame(width: 100, height: 100)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(user.preferences.color.rawValue), lineWidth: 4))
                                    
                                }
                                if isEditing {
                                    HStack {
                                        VStack {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 30, height: 30)
                                                Image(systemName: "xmark.circle.fill")
                                                    .onTapGesture {
                                                        modelContext.delete(user)
                                                    }
                                                    .font(.title)
                                                    .foregroundColor(.red)
                                            }
                                            
                                            Spacer()
                                        }
                                        Spacer()
                                    }
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
                                    .modifier(MinimalModifier(.headline))
                            }
                            .foregroundStyle(Color(BogshColorType.accent.rawValue))
                            .frame(width: 100, height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(BogshColorType.accent.rawValue), lineWidth: 4))
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("bogPhoneOS")
                        .modifier(MinimalModifier(.title3))
                        .foregroundStyle(Color(BogshColorType.accent.rawValue))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Text(isEditing ? "Editing" : "Edit")
                        .modifier(MinimalModifier())
                        .foregroundStyle(isEditing ? Color(BogshColorType.red.rawValue) : Color(BogshColorType.accent.rawValue))
                        .padding()
                        .onTapGesture {
                            isEditing.toggle()
                        }
                }
            }
        }
        
    }
}

#Preview {
    BogInView()
        .modelContainer(for: User.self, inMemory: true)
}
