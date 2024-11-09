//
//  ContentView.swift
//  WeSplit
//
//  Created by Simon Zwicker on 01.11.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double = .init()
    @State private var numberOfPeople: Int = 0
    @State private var tipPercentage: Double = 20
    @FocusState private var isFocused: Bool
    let currencyFormat: String = Locale.current.currency?.identifier ?? "EUR"
    
    var totalPerPerson: Double {
        let tip = checkAmount / 100 * tipPercentage
        return tip / Double(numberOfPeople + 2)
    }
    
    var total: Double {
        return (checkAmount / 100 * tipPercentage) + checkAmount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyFormat))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Slider(value: $tipPercentage, in: 0...100, step: 1)
                    Text("\(Int(tipPercentage), format: .percent)")
                        .font(.largeTitle)
                }
                
                Section("Tip cost per person") {
                    Text(totalPerPerson, format: .currency(code: currencyFormat))
                }
                
                Section("Total include Tip") {
                    Text(total, format: .currency(code: currencyFormat))
                        .foregroundStyle(tipPercentage > 0 ? .black: .red) // Day 24 Challenge 1.
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
    ContentView()
}
