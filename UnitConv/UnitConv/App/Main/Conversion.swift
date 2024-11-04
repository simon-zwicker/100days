//
//  Conversion.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

enum Conversion: String, CaseIterable {
    case length = "Länge"
    case time = "Zeit"
    case temperature = "Temperatur"
    case volume = "Volumen"
}

extension Conversion {
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .length: LengthScreen()
        case .time: TimeScreen()
        case .temperature: TemperatureScreen()
        case .volume: VolumeScreen()
        }
    }
}
