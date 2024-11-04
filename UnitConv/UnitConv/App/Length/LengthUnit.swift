//
//  LengthUnit.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import Foundation

enum LengthUnit: CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles
}

extension LengthUnit {
    var measurment: UnitLength {
        switch self {
        case .meters: .meters
        case .kilometers: .kilometers
        case .feet: .feet
        case .yards: .yards
        case .miles: .miles
        }
    }
}
