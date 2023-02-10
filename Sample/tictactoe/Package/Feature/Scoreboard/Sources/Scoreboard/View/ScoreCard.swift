//
//  ScoreCard.swift
//  
//
//  Created by JSilver on 2023/01/30.
//

import SwiftUI

struct ScoreCard: View {
    // MARK: - View
    var body: some View {
        VStack {
            Text(name)
                .lineLimit(1)
            ZStack {
                Text("\(score)")
                    .font(.title)
            }
                .frame(maxWidth: .infinity, maxHeight: 80)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(
                            isHighlight ? Color(.tintColor) : Color(.systemGray),
                            lineWidth: 1
                        )
                }
        }
    }
    
    // MARK: - Property
    var name: String
    var score: Int
    var isHighlight: Bool
    
    // MARK: - Initializer
    
    // MARK: - Lifecycle

    // MARK: - Public

    // MARK: - Private
}
