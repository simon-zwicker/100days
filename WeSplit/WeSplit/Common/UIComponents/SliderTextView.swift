//
//  SliderTextView.swift
//  WeSplit
//
//  Created by Simon Zwicker on 03.11.24.
//

import SwiftUI

struct SliderTextView: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double
    
    init(
        value: Binding<Double>,
        range: ClosedRange<Double> = 0...100,
        step: Double = 1
    ) {
        self._value = value
        self.range = range
        self.step = step
    }
    
    var body: some View {
        VStack {
            Text("\(Int(value), format: .percent)")
            Slider(value: $value, in: range, step: step)
        }
    }
}
