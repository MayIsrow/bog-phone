//
//  BogshView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

struct BogshView: View {
    @State var bogsh: BogshModel
    @State private var text = ""
    @State var isInputEnabled = true
    
    var body: some View {
        VStack {
            switch bogsh.app {
            case .smiley:
                SmileyView()
            case .frog:
                FrogView()
            default:
                console
            }
            
            TerminalTextField("bogsh", text: $text, accentColor: Color("accent"), isInputEnabled: $isInputEnabled) {
                withAnimation {
                    writeToConsole(text)
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    var console: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    ForEach(bogsh.lines, id: \.self) { line in
                        HStack {
                            Text("\(String(line.id.uuidString.prefix(3)))~\(line.text)")
                                .modifier(MinimalModifier(line.textStyle, design: line.design, color: line.color))
                            Spacer()
                        }
                        .padding(.leading, 6)
                        .padding([.vertical],3)
                        .id(line.id)
                    }
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("accent"), lineWidth: 2))
                .modifier(MinimalModifier(color: Color("accent")))
                .padding()
                .onChange(of: bogsh.lines.last?.id) { id in
                    scrollView.scrollTo(id, anchor: .bottom)
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
    BogshView(bogsh: BogshModel(parent: BogshModels()))
}
