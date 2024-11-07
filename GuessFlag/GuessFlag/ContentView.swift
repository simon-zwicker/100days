//
//  ContentView.swift
//  GuessFlag
//
//  Created by Simon Zwicker on 05.11.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Monaco", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isScoreShowed: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    @State private var questionCount: Int = 0
    
    var body: some View {
        ZStack {
            MeshGradient(width: 3, height: 3, points: [
                .init(0, 0), .init(0.5, 0), .init(1, 0),
                .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
                .init(0, 1), .init(0.5, 1), .init(1, 1)
            ], colors: [
                .blue, .teal, .teal,
                .teal, .blue, .blue,
                .teal, .teal, .blue
            ])
            .ignoresSafeArea()
            
            if questionCount == 8 {
                VStack {
                    Text("Dein Score: \(score)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.secondary)
                    
                    Button("Neu starten") {
                        questionCount = 0
                        score = 0
                        isScoreShowed = false
                        scoreTitle = ""
                        askQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                VStack {
                    Spacer()
                    
                    Text("Guess the flag")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .foregroundStyle(.secondary)
                        .contentTransition(.numericText())
                    
                    Spacer()
                    
                    VStack(spacing: 15.0) {
                        
                        VStack {
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                            
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.semibold))
                        }
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 20)
                        
                        ForEach(0..<3) { number in
                            Button {
                                onFlagTapped(number)
                            } label: {
                                Image(countries[number].lowercased())
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    .padding()
                }
                .padding()
            }
        }
        .alert(scoreTitle, isPresented: $isScoreShowed) {
            Button("Next Question", action: askQuestion)
        } message: {
            Text("Your current score: \(score)")
        }
    }
    
    private func onFlagTapped(_ number: Int) {
        withAnimation {
            let isCorrect = number == correctAnswer
            scoreTitle = isCorrect ? "Correct!" : "Wrong!"
            score += isCorrect ? 30: 0
            
            if !isCorrect {
                scoreTitle += "\n This is the flag from \(countries[number])"
            }
            
            isScoreShowed = questionCount < 7 ? true: false
            questionCount += 1
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
