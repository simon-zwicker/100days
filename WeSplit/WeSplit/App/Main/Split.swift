//
//  Split.swift
//  WeSplit
//
//  Created by Simon Zwicker on 03.11.24.
//

import Foundation

@Observable
class Split {
    var checkAmount: Double
    var people: Double
    var tipPercentage: Double
    
    private var tipAmount: Double {
        checkAmount / 100 * tipPercentage
    }
    
    var totalPerPerson: Double {
        return tipAmount / people
    }
    
    var total: Double {
        return checkAmount + tipAmount
    }
    
    private(set) var currencyFormatter: String = Locale.current.currency?.identifier ?? "EUR"
    
    init() {
        self.checkAmount = 0
        self.people = 2
        self.tipPercentage = 10
    }
}
