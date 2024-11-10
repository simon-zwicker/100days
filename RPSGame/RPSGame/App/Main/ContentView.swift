//
//  ContentView.swift
//  RPSGame
//
//  Created by Simon Zwicker on 10.11.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var npcSelection: RPS = .paper
    @State private var playerSelection: RPS = .paper
    @State private var shouldLose: Bool = false
    @State private var roundEnd: Bool = false
    @State private var hasWon: String = ""
    @State private var round: Int = 1
    @State private var score: Int = 0
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea().background(
                Color.yellow.gradient
            )
            
            VStack {
                Text("Punkte: \(score)")
                    .padding()
                    .font(.largeTitle.bold())
                    .foregroundStyle(.indigo)
                
                Text("Wähle um zu \(shouldLose ? "verlieren" : "gewinnen")")
                    .font(.title.bold())
                
                HStack(spacing: 30.0) {
                    ForEach(RPS.allCases, id: \.self) { type in
                        Button {
                            checkAnswer(type)
                        } label: {
                            VStack(spacing: 15.0) {
                                Image(type.rawValue)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                
                                Text(type.rawValue)
                                    .font(.subheadline.bold())
                            }
                            .padding()
                            .foregroundStyle(.indigo)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.black.gradient.opacity(0.1)
                        )
                        .clipShape(.rect(cornerRadius: 20))
                    }
                }
                
                if roundEnd {
                    VStack(spacing: 30.0) {
                        
                        HStack {
                            VStack {
                                Text("Computer")
                                Image(npcSelection.rawValue)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Text("vs.")
                                 
                            VStack {
                                Text("Spieler")
                                Image(playerSelection.rawValue)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .font(.system(size: 16.0, weight: .black))
                        
                        VStack {
                            Text(hasWon)
                                .font(.system(size: 36.0, weight: .black))
                            
                            if round == 10 {
                                Text("Dein Highscore: \(score)")
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.indigo)
                            }
                            
                            Button("\(round == 10 ? "Neues Spiel" : "Nächste Runde")") {
                                round == 10 ? startGame() : nextRound()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 20.0)
                        }
                    }
                    .padding(.top, 50.0)
                }
            }
            .padding()
            .onAppear {
                startGame()
            }
        }
    }
    
    private func startGame() {
        withAnimation {
            npcSelection = RPS.allCases.randomElement() ?? .paper
            shouldLose = Bool.random()
            roundEnd = false
            hasWon = ""
            round = 1
            score = 0
        }
    }
    
    private func nextRound() {
        withAnimation {
            npcSelection = RPS.allCases.randomElement() ?? .paper
            shouldLose = Bool.random()
            round += 1
            hasWon = ""
            roundEnd = false
        }
    }
    
    private func checkAnswer(_ choosed: RPS) {
        withAnimation {
            if shouldLose {
                hasWon =  npcSelection.loseAgainst(choosed) ? "gewonnen": "verloren"
            } else {
                hasWon = npcSelection.wonAgainst(choosed) ? "gewonnen": "verloren"
            }
            
            if npcSelection.isDrawAgainst(choosed) {
                hasWon = "unentschieden"
            }
            
            playerSelection = choosed
            scoring()
            roundEnd = true
        }
    }
    
    private func scoring() {
        switch hasWon {
        case "gewonnen": score += 1
        default: score -= 1
        }
    }
}

#Preview {
    ContentView()
}
