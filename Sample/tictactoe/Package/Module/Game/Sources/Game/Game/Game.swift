//
//  GameBoard.swift
//  
//
//  Created by JSilver on 2022/12/27.
//

import Foundation

public struct Game {
    // MARK: - Constant
    private static let size = 3
    
    // MARK: - Property
    public private(set) var board: [[GamePiece?]] = [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
    ]
    
    // MARK: - Initializer
    public init() { }
    
    // MARK: - Public
    /// Place the piece at position.
    public mutating func place(piece: GamePiece, position: (row: Int, column: Int)) throws {
        let (row, column) = position
        guard (0 ..< 3).contains(row) && (0 ..< 3).contains(column) else { throw GameError.invalidPosition }
        
        guard board[row][column] == nil else { throw GameError.invalidPosition }
        
        board[row][column] = piece
    }
    
    /// Check winner based on current board state.
    /// Return `nil` when it can't determine result.
    public func checkWinner() -> GameResult? {
        // Check rows.
        for row in 0 ..< Game.size {
            guard let winner = board[row][0] else { continue }
            
            guard (1 ..< Game.size).map ({ board[row][$0] })
                .allSatisfy({ $0 == winner })
            else { continue }
            
            return .end(winner: winner)
        }
        
        // Check columns.
        for column in 0 ..< Game.size {
            guard let winner = board[0][column] else { continue }
            
            guard (1 ..< Game.size).map ({ board[$0][column] })
                .allSatisfy({ $0 == winner })
            else { continue }
            
            return .end(winner: winner)
        }
        
        // Check diagonals.
        guard let center = board[1][1] else { return nil }
        
        if let winner = board[0][0] {
            if center == winner && board[2][2] == winner {
                return .end(winner: winner)
            }
        }
        
        if let winner = board[2][0] {
            if center == winner && board[0][2] == winner {
                return .end(winner: winner)
            }
        }
        
        // Check draw.
        guard board.flatMap({ $0 })
            .allSatisfy({ $0 != nil })
        else {
            return nil
        }
        
        return .draw
    }
    
    // MARK: - Private
}
