//
//  StartingView.swift
//  KidsMultiply
//
//  Created by Simon Zwicker on 21.11.24.
//

import SwiftUI

struct StartingView: View {
    
    // MARK: - Properties
    @State var tables: ClosedRange<Int> = 2...12
    @State var selectedTables: [Int] = []
    @State var rounds: [Int] = [5, 10, 20]
    @State var selectedRounds: Int = 10
    @State var question: (Int, Int) = (2, 2)
    @State var currentRound: Int = 0
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Text("Select Multiplication Tables")
                
                LazyVGrid(columns: [.init(), .init(), .init(), .init(), .init()]) {
                    ForEach(tables, id: \.self) { table in
                        Button(table.description) {
                            tableSelected(table)
                        }
                        .font(.system(size: 16.0, weight: .black))
                        .foregroundStyle(selectedTables.contains(table) ? Color.white : Color.pink)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(width: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedTables.contains(table) ? Color.pink : Color.clear)
                                .stroke(selectedTables.contains(table) ? Color.clear : Color.pink, lineWidth: 2)
                        )
                    }
                }
            }
            
            VStack(spacing: 20) {
                Text("How much Rounds do you want to play?")
                
                HStack {
                    ForEach(rounds, id: \.self) { round in
                        Button(round.description) {
                            selectedRounds = round
                        }
                        .font(.system(size: 22.0, weight: .black))
                        .foregroundStyle(selectedRounds == round ? Color.white : Color.teal)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(width: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(selectedRounds == round ? Color.teal : Color.clear)
                                .stroke(selectedRounds == round ? Color.clear : Color.teal, lineWidth: 2)
                        )
                    }
                }
            }
            
            Spacer()
            
            NavigationLink(destination: GameView(tables: selectedTables, rounds: selectedRounds), label: {
                Text("Start Game")
                    .font(.title.bold())
                    .foregroundStyle(selectedTables.isEmpty ? .gray: .blue)
            })
            .disabled(selectedTables.isEmpty)
        }
        .padding()
    }
    
    private func tableSelected(_ number: Int) {
        if selectedTables.contains(number) {
            selectedTables.removeAll(where: { $0 == number })
        } else {
            selectedTables.append(number)
        }
    }
}

#Preview {
    StartingView()
}
