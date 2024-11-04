//
//  TemperatureScreen.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

struct TemperatureScreen: View {
    
    // MARK: - Properties
    @State var availableUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    @State var fromTemp: Measurement<UnitTemperature> = .init(value: 15, unit: .celsius)
    @State var toTemp: Measurement<UnitTemperature>?
    @State var fromSelection: UnitTemperature = .celsius
    @State var toSelection: UnitTemperature = .fahrenheit
    
    private var changed: [String] {
        [fromSelection.description, toSelection.description, fromTemp.value.description]
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 50.0) {
            HStack {
                TextField("", value: $fromTemp.value, format: .number)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 52.0, weight: .black))
                
                Menu {
                    ForEach(availableUnits, id: \.self) { unit in
                        Button(unit.name, action: {
                            self.fromSelection = unit
                        })
                    }
                } label: {
                    Label(fromSelection.name, systemImage: "chevron.down")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            
            if let toTemp {
                HStack {
                    Text(toTemp.value, format: .number)
                        .font(.system(size: 40.0, weight: .bold))
                        .foregroundStyle(.gray)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    Menu {
                        ForEach(availableUnits, id: \.self) { unit in
                            Button(unit.name, action: {
                                self.toSelection = unit
                            })
                        }
                    } label: {
                        Label(toSelection.name, systemImage: "chevron.down")
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
        }
        .onChange(of: changed) {
            withAnimation {
                recalculate()
            }
        }
        .task {
            withAnimation {
                recalculate()
            }
        }
    }
    
    private func recalculate() {
        fromTemp = .init(value: fromTemp.value, unit: fromSelection)
        toTemp = nil
        let updateTo = fromTemp.converted(to: toSelection)
        toTemp = .init(value: updateTo.value, unit: updateTo.unit)
    }
}
