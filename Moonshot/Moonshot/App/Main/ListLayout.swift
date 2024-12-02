//
//  ListLayout.swift
//  Moonshot
//
//  Created by Simon Zwicker on 28.11.24.
//

import SwiftUI

struct ListLayout: View {
    
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions, id: \.id) { mission in
                NavigationLink(value: mission) {
                    HStack(spacing: 30.0) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.title.bold())
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}
