//
//  ConsoleView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/16/23.
//

import SwiftUI

struct ConsoleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var consoleController: ConsoleController

    @State private var text = ""
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                switch consoleController.console.state {
                case .frog:
                    FrogView()
                case .hole:
                    HoleView()
                case .smiley:
                    SmileyView()
                default:
                    ScrollView {
                        consoleLinesView
                    }
                     
                    .modifier(MinimalModifier())
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(consoleController.preferences.color.rawValue), lineWidth: 2))
                    .padding()
                    .onChange(of: consoleController.console.consoleLines.sorted(by: {$0.date < $1.date}).last?.id) { id in
                        scrollView.scrollTo(id, anchor: .bottom)
                    }
                    .onAppear {
                        scrollView.scrollTo(consoleController.console.consoleLines.sorted(by: {$0.date < $1.date}).last?.id, anchor: .bottom)
                    }
                }
                ConsoleTextField(placeHolderText:"bogsh", text: $text, consoleController: consoleController) {
                    if consoleController.console.consoleLines.sorted(by: {$0.date < $1.date}).count == 0 {
                        withAnimation {
                            writeToConsole(text)
                        }
                    } else {
                        writeToConsole(text)
                    }
                }
                .foregroundStyle(Color(consoleController.preferences.color.rawValue))
                .tint(Color(consoleController.preferences.color.rawValue)) // This makes the
                .padding([.horizontal, .bottom])
                .onTapGesture {
                    scrollView.scrollTo(consoleController.console.consoleLines.sorted(by: {$0.date < $1.date}).last?.id, anchor: .bottom)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(consoleController.preferences.name)
                    .modifier(MinimalModifier(.title3))
                    .foregroundStyle(Color(consoleController.preferences.color.rawValue))
            }
            
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
        .toolbarBackground(.hidden, for: .automatic)
    }
    
    var consoleLinesView: some View {
        ForEach(consoleController.console.consoleLines.sorted(by: {$0.date < $1.date})) { line in
            HStack {
                Text("\(String(line.id.uuidString.prefix(3)))~\(line.text)")
                    .foregroundStyle(Color(line.color.rawValue))
                    .modifier(MinimalModifier())
                    .onTapGesture {
                        text = line.text
                    }
                Spacer()
            }
            .padding(.leading, 6)
            .padding([.vertical],3)
            .id(line.id)
        }
    }
    
    private func writeToConsole(_ text: String) {
        self.text = ""
        consoleController.push("\(text)")
    }
}

#Preview {
    BogInView()
        .modelContainer(for: User.self, inMemory: true)
}

