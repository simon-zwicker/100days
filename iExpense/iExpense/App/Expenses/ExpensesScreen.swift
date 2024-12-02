//
//  ExpensesScreen.swift
//  iExpense
//
//  Created by Simon Zwicker on 23.11.24.
//

import SwiftUI

struct ExpensesScreen: View {
    
    // MARK: - Properties
    @Environment(\.expenses) private var expenses
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(ExpenseType.allCases, id: \.self) { type in
                if !expenses.items.filter({ $0.type == type }).isEmpty {
                    Section(type.rawValue) {
                        ForEach(expenses.items.filter({ $0.type == type }), id: \.id) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type.rawValue)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: expenses.user.curreny))
                                    .foregroundStyle(costColor(item.amount))
                            }
                        }
                        .onDelete(perform: expenses.remove)
                    }
                }
            }
        }
        .toolbar {
            NavigationLink("Add Expense") {
                ExpenseAdd()
            }
        }
    }
    
    private func costColor(_ cost: Double) -> Color {
        cost <= 10 ? .green: cost <= 100 ? .orange: .red
    }
}

// MARK: - Preview
#Preview {
    ExpensesScreen()
}
