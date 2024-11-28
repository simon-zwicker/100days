//
//  LabelDivider.swift
//  Moonshot
//
//  Created by Simon Zwicker on 28.11.24.
//

import SwiftUI

struct LabelDivider: View {
    
    let label: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.lightBackground)
                .padding(.vertical)
            
            Text(label)
                .font(.headline.bold())
                .padding(.horizontal)
                .background(.darkBackground)
        }
    }
}

#Preview {
    LabelDivider(label: "Test")
}
