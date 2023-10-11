//
//  HoleView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI
import AVFAudio

struct HoleView: View {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    let utterance = AVSpeechUtterance(string: "Welcome to your hole. It's safe here.")
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                speechSynthesizer.speak(utterance)
            } label: {
                Text("🕳️")
                    .font(.system(size: 150))
            }
            Text("welcome to your hole.")
            Text("it's safe here.")
            Spacer()
        }
        .onAppear {
            utterance.pitchMultiplier = 1.0
            utterance.rate = 0.4
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            
            
        }
    }
}

#Preview {
    HoleView()
}
