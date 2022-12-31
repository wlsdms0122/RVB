//
//  Player.swift
//  
//
//  Created by JSilver on 2022/12/27.
//

import Foundation

/// The game player information.
public struct Player: Equatable, Codable {
    // MARK: - Property
    public let name: String
    public var score: Int
    
    // MARK: - Initializer
    public init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
    
    // MARK: - Public
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
    
    func won() -> Player {
        .init(name: name, score: score + 1)
    }
    
    // MARK: - Private
}
