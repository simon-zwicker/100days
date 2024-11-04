//
//  LengthScreen.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

struct LengthScreen: View {
    
    // MARK: - Properties
    @State var availableUnits: [UnitLength] = [.meters, .kilometers, .miles, .feet, .yards]
    @State var fromSelection: UnitLength = .meters
    @State var toSelection: UnitLength = .kilometers
    @State var fromUnit: Measurement<UnitLength> = .init(value: 1.0, unit: .meters)
    @State var toUnit: Measurement<UnitLength>?
    
    private var changed: [String] {
        [fromSelection.description, toSelection.description, fromUnit.value.description]
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 50.0) {
            HStack {
                TextField("", value: $fromUnit.value, format: .number)
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
            
            if let toUnit {
                HStack {
                    Text(toUnit.value, format: .number)
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
        fromUnit = .init(value: fromUnit.value, unit: fromSelection)
        toUnit = nil
        let updateTo = fromUnit.converted(to: toSelection)
        toUnit = .init(value: updateTo.value, unit: updateTo.unit)
    }
}

#Preview {
    LengthScreen()
}
