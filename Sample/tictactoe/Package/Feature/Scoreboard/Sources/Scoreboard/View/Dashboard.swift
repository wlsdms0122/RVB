//
//  Dashboard.swift
//  
//
//  Created by JSilver on 2023/01/30.
//

import SwiftUI
import Game

struct Dashboard: View {
    // MARK: - View
    var body: some View {
        HStack(spacing: 16) {
            ScoreCard(
                name: players.playerA.name,
                score: players.playerA.score,
                isHighlight: players.playerA == leader
            )
            ScoreCard(
                name: players.playerB.name,
                score: players.playerB.score,
                isHighlight: players.playerB == leader
            )
        }
    }
    
    // MARK: - Property
    var players: Players
    var leader: Player?
    
    // MARK: - Initializer
    
    // MARK: - Public
    
    // MARK: - Private
}
