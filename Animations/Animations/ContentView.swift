//
//  ContentView.swift
//  Animations
//
//  Created by Simon Zwicker on 17.11.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: Double = 0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

#Preview {
    ContentView()
}
