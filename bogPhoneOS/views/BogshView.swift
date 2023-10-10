//
//  BogshView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/9/23.
//

import SwiftUI

struct BogshView: View {
    @ObservedObject var bogsh: BogshController
    @State private var text = ""
    @State private var lastId: UUID?
    
    init(_ bogsh: BogshController = BogshController()) {
        self.bogsh = bogsh
    }
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    ForEach(bogsh.lines, id: \.self) { line in
                        HStack {
                            Text("\(String(line.id.uuidString.prefix(3)))~\(line.text)")
                                .minimal(line.textStyle, design: line.design, color: line.color)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        .padding([.vertical],3)
                        .id(line.id)
                        .onAppear {
                            lastId = line.id
                        }
                    }
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("accent"), lineWidth: 2))
                .minimal(color: Color("accent"))
                .padding()
                .onChange(of: lastId) { _ in
                    if let lastId = lastId {
                        scrollView.scrollTo(lastId, anchor: .bottom)
                    }
                }
                TerminalTextField("bogsh", text: $text, accentColor: Color("accent"), bogsh: bogsh) {
                    if bogsh.lines.isEmpty {
                        withAnimation {
                            bogsh.push("\(text)")
                            text = ""
                        }
                    } else {
                        bogsh.push("\(text)")
                        text = ""
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    BogshView()
}
