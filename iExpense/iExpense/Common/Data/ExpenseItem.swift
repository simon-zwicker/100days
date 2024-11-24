//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Simon Zwicker on 23.11.24.
//

import Foundation

struct ExpenseItem: Codable {
    let id: UUID
    let name: String
    let type: ExpenseType
    let amount: Double
    
    init(id: UUID = .init(), name: String, type: ExpenseType, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
