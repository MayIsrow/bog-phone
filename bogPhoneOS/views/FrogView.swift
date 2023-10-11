//
//  FrogView.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI
import AVFoundation

struct FrogView: View {
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
            Button {
                GSAudio.sharedInstance.playSound(soundFileName: "frog.mp3")
            } label: {
                Text("🐸")
                    .font(.system(size: 150))
            }
        }
    }
}

#Preview {
    FrogView()
}
