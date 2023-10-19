//
//  HomeIcon.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/17/23.
//

import SwiftUI

struct HomeIcon: View {
    
    @State var iconSystemName: String?
    @State var displayName: String = ""
    @State var colorType: BogshColorType = .lightGray
    
    var body: some View {
        VStack {
            VStack {
                if let systemName = iconSystemName {
                    Image(systemName: systemName)
                        .resizable()
                        .padding()
                }
            }
            .frame(width: 80, height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(colorType.rawValue), lineWidth: 4)
            )
            .foregroundStyle(Color(colorType.rawValue))
            Text(displayName)
                .modifier(MinimalModifier())
        }
    }
}

#Preview {
    HomeIcon(iconSystemName: "chevron.right", displayName: "bogsh", colorType: .bogsh)
}
