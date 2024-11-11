//
//  ContentView.swift
//  BetterRest
//
//  Created by Simon Zwicker on 11.11.24.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = .now
    
    private var sleepTimeFormatted: String {
        let hours = Int(sleepAmount)
        let minutes = Int((sleepAmount - Double(hours)) * 60)
        return "\(hours):\(minutes == 0 ? "00": minutes.description)"
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Stepper("\(sleepTimeFormatted) Stunden schlaf", value: $sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Datum eingeben", selection: $wakeUp, in: Date.now...)
                .labelsHidden()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
