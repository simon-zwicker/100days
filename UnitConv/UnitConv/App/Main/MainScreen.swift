//
//  MainScreen.swift
//  UnitConv
//
//  Created by Simon Zwicker on 04.11.24.
//

import SwiftUI

struct MainScreen: View {
    
    // MARK: - Properties
    @State private var selected: Conversion = .time
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 30.0) {
            VStack(alignment: .leading) {
                Text("UnitConv")
                    .font(.largeTitle)
                
                Text("Wandel Werte in verschiedenen Kategorien und verschiedenen Units um.")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            
            Picker("", selection: $selected) {
                ForEach(Conversion.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)

            ScrollView {
                selected.view
            }
            .scrollIndicators(.hidden)
        }
        .padding()
    }
}

#Preview {
    MainScreen()
}
