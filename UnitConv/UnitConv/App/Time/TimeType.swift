//
//  TimeType.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import Foundation

enum TimeType: String, CaseIterable {
    case seconds
    case minutes
    case hours
    case days
}

extension TimeType {
    var durationType: UnitDuration? {
        switch self {
        case .seconds: .seconds
        case .minutes: .minutes
        case .hours: .hours
        default: nil
        }
    }
}
