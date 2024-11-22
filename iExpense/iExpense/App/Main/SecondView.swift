//
//  Untitled.swift
//  iExpense
//
//  Created by Simon Zwicker on 22.11.24.
//

import SwiftUI

struct SecondView: View {
    
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    let name: String
    
    // MARK: - Body
    var body: some View {
        Text("Hello \(name)")
        Button("Close") {
            dismiss()
        }
    }
}
