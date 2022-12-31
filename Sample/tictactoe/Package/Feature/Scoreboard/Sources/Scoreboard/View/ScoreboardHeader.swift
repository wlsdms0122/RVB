//
//  ScoreboardHeader.swift
//  
//
//  Created by JSilver on 2023/01/30.
//

import SwiftUI
import Game
import Resource

struct ScoreboardHeader: View {
    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Text(R.Localizable.scoreboardTitle)
                    .font(.title)
                    .foregroundColor(Color(.label))
                Spacer()
            }
            HStack {
                Group {
                    if let leader {
                        Text(String(format: R.Localizable.scoreboardDescriptionWhoIsLeader, leader.name))
                    } else {
                        Text(R.Localizable.scoreboardDescriptionTie)
                    }
                }
                    .font(.title3)
                    .foregroundColor(Color(.systemGray))
                
                Spacer()
            }
        }
    }
    
    // MARK: - Property
    var leader: Player?
    
    // MARK: - Initializer
    
    // MARK: - Public
    
    // MARK: - PRivate
}
