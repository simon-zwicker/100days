//
//  Expenses.swift
//  iExpense
//
//  Created by Simon Zwicker on 23.11.24.
//

import Foundation

@Observable
class Expenses {
    var items: [ExpenseItem] = .init() {
        didSet {
            guard let encoded = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(encoded, forKey: "ExpenseItems")
        }
    }
    
    var user: User = .init()
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "ExpenseItems") {
            print(saved)
            guard let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: saved) else { return }
            self.items = decoded
        } else {
            self.items = .init()
        }
    }
    
    func add(_ expense: ExpenseItem) {
        items.append(expense)
    }
    
    func remove(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
