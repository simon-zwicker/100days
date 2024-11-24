//
//  ContentView.swift
//  iExpense
//
//  Created by Simon Zwicker on 22.11.24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ExpensesScreen()
                .navigationTitle("iExpense")
        }
    }
}

#Preview {
    ContentView()
}
