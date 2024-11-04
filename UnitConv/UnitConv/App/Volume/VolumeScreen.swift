//
//  VolumeScreen.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

struct VolumeScreen: View {
    
    // MARK: - Properties
    @State var availableUnits: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
    @State var fromVolume: Measurement<UnitVolume> = .init(value: 4, unit: .liters)
    @State var toVolume: Measurement<UnitVolume>?
    @State var fromSelection: UnitVolume = .liters
    @State var toSelection: UnitVolume = .cups
    
    private var changed: [String] {
        [fromSelection.description, toSelection.description, fromVolume.value.description]
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 50.0) {
            HStack {
                TextField("", value: $fromVolume.value, format: .number)
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
            
            if let toVolume {
                HStack {
                    Text(toVolume.value, format: .number)
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
        fromVolume = .init(value: fromVolume.value, unit: fromSelection)
        toVolume = nil
        let updateTo = fromVolume.converted(to: toSelection)
        toVolume = .init(value: updateTo.value, unit: updateTo.unit)
    }
}
