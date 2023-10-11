//
//  BogshViews.swift
//  bogPhoneOS
//
//  Created by May Isrow on 10/10/23.
//

import SwiftUI

struct BogshViews: View {
    @State var bogshModels = BogshModels()
    
    var body: some View {
        ForEach(bogshModels.bogshs) { bogsh in
            //BogshView(bogsh: bogsh)
        }
    }
}

#Preview {
    BogshViews()
}
