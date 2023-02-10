//
//  GameService.swift
//
//
//  Created by JSilver on 2022/12/03.
//

import Foundation

public protocol GameServiceable {
    /// The players.
    var players: Players? { get }
    
    /// Sign in for playing the game.
    func signIn(playerAName: String, playerBName: String) throws
    /// Sign out from the game.
    func signOut()
}

public final class GameService: GameServiceable {
    // MARK: - Constant
    private static let playersKey = "players"
    
    // MARK: - Property
    private let userDefault: UserDefaults
    
    public private(set) var players: Players?
    
    // MARK: - Initializer
    public init(userDefault: UserDefaults) {
        self.userDefault = userDefault
        
        if let data = userDefault.data(forKey: GameService.playersKey) {
            players = try? players(for: data)
        }
    }
    
    // MARK: - Public
    public func signIn(playerAName: String, playerBName: String) throws {
        guard !playerAName.isEmpty && !playerBName.isEmpty else {
            // Throw an error if either player's name is empty.
            throw GameServiceError.emptyPlayerName
        }
        
        guard playerAName != playerBName else {
            // Throw an error if both players name are same.
            throw GameServiceError.samePlayerName
        }
        
        // Create players.
        let players = Players(
            playerA: Player(name: playerAName, score: 0),
            playerB: Player(name: playerBName, score: 0)
        )
        
        // Save players.
        try savePlayers(players)
        
        self.players = players
    }
    
    public func signOut() {
        // Clear players.
        clearPlayers()
        
        players = nil
    }
    
    // MARK: - Private
    private func data(for player: Players) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(player)
    }
    
    private func players(for data: Data) throws -> Players {
        let decoder = JSONDecoder()
        return try decoder.decode(Players.self, from: data)
    }
    
    private func savePlayers(_ players: Players) throws {
        // Save the players.
        userDefault.set(
            try data(for: players),
            forKey: GameService.playersKey
        )
    }
    
    private func clearPlayers() {
        // Remove the players.
        userDefault.removeObject(forKey: GameService.playersKey)
    }
}
