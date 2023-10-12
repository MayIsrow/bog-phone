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
            switch bogsh.model.app {
            case .smiley:
                SmileyView()
            case .frog:
                FrogView()
            case .hole:
                HoleView()
            default:
                console
            }
            TerminalTextField(placeHolderText:"bogsh", text: $text, color: Color("accent"), bogsh: bogsh) {
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
                    ForEach(bogsh.model.lines, id: \.self) { line in
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
                .onChange(of: bogsh.model.lines.last?.id) { id in
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
    BogshView()
}
