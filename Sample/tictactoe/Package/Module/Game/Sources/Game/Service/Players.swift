//
//  Players.swift
//  
//
//  Created by JSilver on 2023/01/13.
//

import Foundation

public struct Players: Equatable, Codable {
    // MARK: - Property
    public var playerA: Player
    public var playerB: Player
    
    // MARK: - Initializer
    public init(
        playerA: Player,
        playerB: Player
    ) {
        self.playerA = playerA
        self.playerB = playerB
    }
    
    // MARK: - Public
    public func won(piece: GamePiece) -> Players {
        switch piece {
        case .a:
            return Players(playerA: playerA.won(), playerB: playerB)
            
        case .b:
            return Players(playerA: playerA, playerB: playerB.won())
        }
    }
    
    // MARK: - Private
}
