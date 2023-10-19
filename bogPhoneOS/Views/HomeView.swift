//
//  HomeView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/17/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var user: User?
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    if let user = user {
                        ConsoleView(consoleController: ConsoleController(console: user.console, preferences: user.preferences))
                    }
                    
                } label: {
                    HomeIcon(iconSystemName: "chevron.right", displayName: "bogsh", colorType: .bogsh)
                }
                .buttonStyle(MinimalButtonStyle())
                Spacer()
                HomeIcon()
                Spacer()
                HomeIcon()
                Spacer()
            }
            Spacer()
            emptyRow
            Spacer()
            emptyRow
            Spacer()
            emptyRow
            Spacer()
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("bog out")
                    .modifier(MinimalModifier())
                    .foregroundStyle(Color(BogshColorType.red.rawValue))
                    .padding()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
    
    var emptyRow: some View {
        HStack {
            Spacer()
            HomeIcon()
            Spacer()
            HomeIcon()
            Spacer()
            HomeIcon()
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
