//
//  ContentView.swift
//  Navigation
//
//  Created by Simon Zwicker on 29.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<1000) { index in
                NavigationLink("Select \(index)", value: index)
            }
            .navigationDestination(for: Int.self) { selection in
                DetailView(number: selection)
            }
            .navigationTitle("Test")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("TapMe") {
                        
                    }
                    
                    Button("TapMe2") {
                        
                    }
                }
            }
        }
    }
}

struct DetailView: View {
    
    var number: Int
    
    var body: some View {
        Text("Detail View \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

struct Student: Hashable {
    var id: UUID = .init()
    var name: String
    var age: Int
}

#Preview {
    ContentView()
}
