//
//  TimeScreen.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

struct TimeScreen: View {
    
    // MARK: - Properties
    @State var fromTimeValue: Double = 10
    @State var fromTimeSelection: TimeType = .minutes
    @State var toTimeValue: Double?
    @State var toTimeSelection: TimeType = .hours
    
    private var changed: [String] {
        [fromTimeValue.description, fromTimeSelection.rawValue, toTimeSelection.rawValue]
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 50.0) {
            HStack {
                TextField("", value: $fromTimeValue, format: .number)
                    .keyboardType(.decimalPad)
                    .font(.system(size: 52.0, weight: .black))
                
                Menu {
                    ForEach(TimeType.allCases, id: \.self) { unit in
                        Button(unit.rawValue, action: {
                            self.fromTimeSelection = unit
                        })
                    }
                } label: {
                    Label(fromTimeSelection.rawValue, systemImage: "chevron.down")
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            
            if let toTimeValue {
                HStack {
                    Text(toTimeValue, format: .number)
                        .font(.system(size: 40.0, weight: .bold))
                        .foregroundStyle(.gray)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    Menu {
                        ForEach(TimeType.allCases, id: \.self) { unit in
                            Button(unit.rawValue, action: {
                                self.toTimeSelection = unit
                            })
                        }
                    } label: {
                        Label(toTimeSelection.rawValue, systemImage: "chevron.down")
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
        guard let fromType = fromTimeSelection.durationType, let toType = toTimeSelection.durationType else {
            calcDay()
            return
        }
        
        let fromTime: Measurement<UnitDuration> = .init(value: fromTimeValue, unit: fromType)
        toTimeValue = fromTime.converted(to: toType).value
    }
    
    private func calcDay() {
        let calcFromDays: Bool = fromTimeSelection == .days
        
        if calcFromDays {
            switch toTimeSelection {
            case .seconds:
                toTimeValue = fromTimeValue * 86400
            case .minutes:
                toTimeValue = fromTimeValue * 1440
            case .hours:
                toTimeValue = fromTimeValue * 24
            default: return
            }
        } else {
            switch fromTimeSelection {
            case .seconds:
                toTimeValue = fromTimeValue / 86400
            case .minutes:
                toTimeValue = fromTimeValue / 1440
            case .hours:
                toTimeValue = fromTimeValue / 24
            default: return
            }
        }
    }
}
