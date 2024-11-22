//
//  ContentView.swift
//  iExpense
//
//  Created by Simon Zwicker on 22.11.24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var user: User = .init()
    @State private var showingSheet: Bool = false
    @State private var numbers: [Int] = .init()
    @State private var currentNumber: Int = 1
    @AppStorage("tapCount") private var tapCount: Int = 0
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Text("Your name is \(user.name) \(user.surname).")
                
                Button("Show Sheet") {
                    showingSheet.toggle()
                }
                
                Button("Save user") {
                    guard let data = try? JSONEncoder().encode(user) else { return }
                    UserDefaults.standard.set(data, forKey: "userData")
                }
                
                List {
                    ForEach(numbers, id: \.self) { number in
                        Text("Row \(number)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                }
            }
            .padding()
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "@simonzwicker")
            }
            .toolbar {
                EditButton()
            }
        }
    }
    
    // MARK: - Helpers
    private func removeRows(_ offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
