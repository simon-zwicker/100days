//
//  ContentView.swift
//  Moonshot
//
//  Created by Simon Zwicker on 25.11.24.
//

import SwiftUI
import Octopus

struct MainView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showGrid: Bool = true
    
    var body: some View {
        NavigationStack {
            Group {
                if showGrid {
                    GridLayout(missions: missions, astronauts: astronauts)
                } else {
                    ListLayout(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .toolbar {
                Button {
                    withAnimation {
                        showGrid.toggle()
                    }
                } label: {
                    Image(systemName: showGrid ? "list.bullet": "square.grid.2x2.fill")
                        .font(.title)
                        .foregroundStyle(.white)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}

