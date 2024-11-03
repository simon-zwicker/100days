//
//  ContentView.swift
//  WeSplit
//
//  Created by Simon Zwicker on 01.11.24.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var split: Split = .init()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill to pay") {
                    TextField("Amount", value: $split.checkAmount, format: .currency(code: split.currencyFormatter))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    SliderTextView(value: $split.people, range: 2...100)
                }
                
                Section("How much do you want to tip?") {
                    SliderTextView(value: $split.tipPercentage)
                }
                
                Section("Tip cost per person") {
                    Text(split.totalPerPerson, format: .currency(code: split.currencyFormatter))
                }
                
                Section("Total amount (incl. tip)") {
                    Text(split.total, format: .currency(code: split.currencyFormatter))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused.toggle() 
                    }
                }
            }
        }
    }
}

#Preview {
    MainScreen()
}
