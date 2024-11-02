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
    @State private var tipPercentage: Int = 20
    @FocusState private var isFocused: Bool
    
    let currencyFormat: String = Locale.current.currency?.identifier ?? "EUR"
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let tip = checkAmount / 100 * Double(tipPercentage)
        return tip / Double(numberOfPeople + 2)
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
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Tip cost per person") {
                    Text(totalPerPerson, format: .currency(code: currencyFormat))
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
