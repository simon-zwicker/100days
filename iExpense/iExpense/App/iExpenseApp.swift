//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Simon Zwicker on 22.11.24.
//

import SwiftUI

@main
struct iExpenseApp: App {
    
    // MARK: - Properties
    @State private var expenses: Expenses = .init()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(expenses)
        }
    }
}
