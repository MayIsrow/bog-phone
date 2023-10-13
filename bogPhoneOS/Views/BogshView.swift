//
//  BogshView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

struct BogshView: View {
    
    @StateObject var bogsh: BogshController = BogshController()
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            if bogsh.isVisible {
                ScrollViewReader { scrollView in
                    HStack {
                        Image(systemName: "microbe.circle")
                            .modifier(MinimalModifier(.title3, color: Color(bogsh.model.userColor.rawValue)))
                        Text("bogPhoneOS")
                            .modifier(MinimalModifier(.title3, color: Color(bogsh.model.userColor.rawValue)))
                    }
                    switch bogsh.model.app {
                    case .smiley:
                        SmileyView()
                    case .frog:
                        FrogView()
                    case .hole:
                        HoleView()
                    default:
                        VStack {
                            ScrollView {
                                ForEach(bogsh.model.lines, id: \.self) { line in
                                    HStack {
                                        Text("\(String(line.id.uuidString.prefix(3)))~\(line.text)")
                                            .modifier(MinimalModifier(color: Color(line.color.rawValue)))
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
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(bogsh.model.userColor.rawValue), lineWidth: 2))
                            .modifier(MinimalModifier(color: Color(bogsh.model.userColor.rawValue)))
                            .padding()
                            .onChange(of: bogsh.model.lines.last?.id) { id in
                                scrollView.scrollTo(id, anchor: .bottom)
                            }
                            .onAppear {
                                scrollView.scrollTo(bogsh.model.lines.last?.id, anchor: .bottom)
                            }
                        }
                    }
                    TerminalTextField(placeHolderText:"bogsh", text: $text, color: Color(bogsh.model.userColor.rawValue), bogsh: bogsh) {
                        if bogsh.model.lines.count == 0 {
                            withAnimation {
                                writeToConsole(text)
                            }
                        } else {
                            writeToConsole(text)
                        }
                        
                    }
                    .padding([.horizontal, .bottom])
                    .onTapGesture {
                        scrollView.scrollTo(bogsh.model.lines.last?.id, anchor: .bottom)
                    }
                }
            }
        }
    }
    private func writeToConsole(_ text: String) {
        self.text = ""
        bogsh.push("\(text)")
    }
}

#Preview {
    BogshView()
}
