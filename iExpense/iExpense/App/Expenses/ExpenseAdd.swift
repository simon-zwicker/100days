//
//  ExpenseAdd.swift
//  iExpense
//
//  Created by Simon Zwicker on 23.11.24.
//

import SwiftUI

struct ExpenseAdd: View {
    
    // MARK: - Properties
    @Environment(\.expenses) private var expenses
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = "Ausgaben Titel bearbeiten"
    @State private var type: ExpenseType = .personal
    @State private var amount: Double = 0.0
    
    // MARK: - Body
    var body: some View {
        Form {
            Picker("Type", selection: $type) {
                ForEach(ExpenseType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            
            TextField("Amount", value: $amount, format: .currency(code: expenses.user.curreny))
                .keyboardType(.decimalPad)
        }
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            Button("Save") {
                let item: ExpenseItem = .init(name: name, type: type, amount: amount)
                expenses.add(item)
                dismiss()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
