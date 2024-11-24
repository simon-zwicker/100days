//
//  ExpenseType.swift
//  iExpense
//
//  Created by Simon Zwicker on 23.11.24.
//

enum ExpenseType: String, CaseIterable, Codable {
    case personal = "Personal"
    case business = "Business"
}
