//
//  RPS.swift
//  RPSGame
//
//  Created by Simon Zwicker on 10.11.24.
//

enum RPS: String, CaseIterable {
    case rock = "Stein"
    case paper = "Papier"
    case scissors = "Schere"
}

extension RPS {
    func isDrawAgainst(_ other: RPS) -> Bool {
        return self == other
    }
    
    func wonAgainst(_ other: RPS) -> Bool {
        switch other {
        case .rock: return self == .scissors
        case .paper: return self == .rock
        case .scissors: return self == .paper
        }
    }
    
    func loseAgainst(_ other: RPS) -> Bool {
        return !wonAgainst(other)
    }
}
