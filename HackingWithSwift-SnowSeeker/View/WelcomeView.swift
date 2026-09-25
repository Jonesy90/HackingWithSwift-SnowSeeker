//
//  WelcomeView.swift
//  HackingWithSwift-SnowSeeker
//
//  Created by Michael Jones on 24/09/2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left hand menu. Swipe from the edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
