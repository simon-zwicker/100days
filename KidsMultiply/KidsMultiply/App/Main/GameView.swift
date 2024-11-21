//
//  GameView.swift
//  KidsMultiply
//
//  Created by Simon Zwicker on 21.11.24.
//

import SwiftUI

struct GameView: View {
    
    // MARK: - Properties
    let tables: [Int]
    let rounds: Int
    @Environment(\.dismiss) private var dismiss
    @State private var currentRound: Int = 1
    @State private var score: Int = 0
    @State private var answer: Int?
    @State private var showResult = false
    @State private var question: (Int, Int) = (1, 1)
    @State private var wasCorrect: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.system(size: 24, weight: .black))
            
            HStack {
                Text("\(question.0) x \(question.1)")
                    .font(.system(size: 54, weight: .black))
                    .foregroundStyle(.black.gradient)
                    .contentTransition(.numericText())
                
                Text("=")
                    .font(.system(size: 54, weight: .black))
                    .foregroundStyle(.black.gradient)
                
                Text("??")
                    .font(.system(size: 54, weight: .black))
                    .foregroundStyle(.indigo.gradient)
            }
            .frame(maxWidth: .infinity)
            .padding(40)
            .background(.yellow.gradient)
            .clipShape(.rect(cornerRadius: 20))
            
            TextField("Answer", value: $answer, format: .number)
                .padding()
                .background(.yellow.opacity(0.5))
                .frame(width: 150)
                .multilineTextAlignment(.center)
                .clipShape(.rect(cornerRadius: 15.0))
                .font(.system(size: 22, weight: .black))
                .padding(.top, 30)
            
            if showResult {
                VStack {
                    Image(systemName: wasCorrect ? "checkmark": "xmark")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundStyle(wasCorrect ? .green: .red)
                    
                    Text("\(answer ?? 0) is \(question.0) x \(question.1) = \(question.0 * question.1)")
                        .font(.system(size: 22, weight: .black))
                        .padding()
                    
                    Button(currentRound == rounds ? "New Game":"Next") {
                        withAnimation {
                            currentRound == rounds ? dismiss(): next()
                        }
                    }
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                }
                .padding(.top, 30)
            }
        }
        .navigationTitle("Round \(currentRound) from \(rounds)")
        .navigationBarBackButtonHidden()
        .onAppear {
            withAnimation {
                generateQuestion()
            }
        }
        .padding()
        .onSubmit {
            withAnimation {
                checkAnswer()
            }
        }
    }
    
    // MARK: - Helpers
    private func generateQuestion() {
        guard let table = tables.randomElement() else { return }
        question = (table, Int.random(in: 1...12))
    }
    
    private func next() {
        showResult = false
        self.answer = nil
        
        currentRound += 1
        
        generateQuestion()
    }
    
    private func checkAnswer() {
        guard let answer else { return }
        let correct = question.0 * question.1
        
        if answer == correct {
            score += 1
        }
        showResult = true
        wasCorrect = answer == correct
    }
}

#Preview {
    GameView(tables: [2, 5, 7], rounds: 3)
}
