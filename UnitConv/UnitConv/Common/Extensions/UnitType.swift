//
//  UnitType.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import Foundation

extension UnitLength {
    var name: String {
        let formatter: MeasurementFormatter = .init()
        formatter.unitStyle = .long
        return formatter.string(from: self)
    }
}

extension UnitTemperature {
    var name: String {
        let formatter: MeasurementFormatter = .init()
        formatter.unitStyle = .short
        return formatter.string(from: self)
    }
}

extension UnitVolume {
    var name: String {
        let formatter: MeasurementFormatter = .init()
        formatter.unitStyle = .long
        return formatter.string(from: self)
    }
}
