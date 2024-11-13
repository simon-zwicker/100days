//
//  ContentView.swift
//  BetterRest
//
//  Created by Simon Zwicker on 11.11.24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = ContentView.defaultWakeTime
    @State private var coffeeAmount: Int = 1
    @State private var bedTime: Date = .now
    @State private var isPredicted: Bool = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var sleepTimeFormatted: String {
        let hours = Int(sleepAmount)
        let minutes = Int((sleepAmount - Double(hours)) * 60)
        return "\(hours):\(minutes == 0 ? "00": minutes.description)"
    }
    
    var changed: [String] {
        [sleepAmount.description, wakeUp.description, coffeeAmount.description]
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Wann willst du aufwachen?")) {
                        DatePicker("Datum eingeben", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    Section(header: Text("Schlafbedarf bestimmen")) {
                        Stepper("\(sleepTimeFormatted) Stunden", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    Section(header: Text("Täglicher Kaffeekonsum")) {
                        Picker("Kaffetassen", systemImage: "cup.and.saucer.fill", selection: $coffeeAmount) {
                            ForEach(0...20, id: \.self) { amount in
                                Text("\(amount)")
                            }
                        }
                    }
                }
                
                if isPredicted {
                    VStack(spacing: 20) {
                        Text("Gehe am besten")
                            .font(.title)
                        Text(bedTime.formatted(date: .omitted, time: .shortened))
                            .font(.largeTitle.bold())
                            .foregroundStyle(
                                        LinearGradient(colors: [.teal, .blue], startPoint:
                                        .topLeading, endPoint: .bottomTrailing
                                        )
                                    )
                        Text("schlafen.")
                            .font(.title)
                    }
                }
            }
            .onChange(of: changed) {
                withAnimation {
                    isPredicted = false
                    self.caluclateSleepTime()
                }
            }
            .navigationTitle("BetterRest")
        }
        .onAppear {
            self.caluclateSleepTime()
        }
    }
    
    func caluclateSleepTime() {
        do {
            let config: MLModelConfiguration = .init()
            let model: BetterRestML = try BetterRestML(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = components.hour ?? 0 * 60 * 60
            let minute = components.minute ?? 0 * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            withAnimation {
                bedTime = wakeUp - prediction.actualSleep
                isPredicted = true
            }
        } catch {
            print("Something went wrong: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
