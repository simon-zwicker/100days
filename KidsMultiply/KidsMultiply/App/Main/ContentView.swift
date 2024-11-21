//
//  ContentView.swift
//  KidsMultiply
//
//  Created by Simon Zwicker on 21.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StartingView()
                .navigationTitle("KidsMultiply")
        }
    }
}

#Preview {
    ContentView()
}
