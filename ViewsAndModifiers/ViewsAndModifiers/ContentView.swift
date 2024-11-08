//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Simon Zwicker on 08.11.24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
        }
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}


#Preview {
    ContentView()
}
