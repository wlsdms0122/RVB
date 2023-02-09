//
//  OnGameViewReactor.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import Foundation
import ReactorKit
import Game

final class OnGameViewReactor: Reactor {
    enum Action {
        /// Place a game piece at row & column.
        case place(at: (Int, Int))
    }
    
    enum Mutation {
        /// Set board.
        case setBoard([[GamePiece?]])
        /// Set turn to next.
        case setNextTurn
        /// Set game ended
        case setGameEnded(GameResult)
        /// Set error.
        case setError(Error)
    }
    
    struct State {
        /// Player A
        var playerA: Player
        /// Player B
        var playerB: Player
        /// Game board
        var board: [[GamePiece?]]
        /// Current turn
        var turn: GamePiece
        /// Game ended event
        @Pulse
        var didGameEnd: GameResult?
        /// Error occur event
        @Pulse
        var error: Error?
    }
    
    // MARK: - Property
    private var game = Game()
    
    var initialState: State
    
    // MARK: - Initializer
    init(
        players: Players
    ) {
        initialState = State(
            playerA: players.playerA,
            playerB: players.playerB,
            board: game.board,
            turn: .a
        )
    }
    
    // MARK: - Lifecycle
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .place(at: position):
            return actionPlace(at: position)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setBoard(board):
            state.board = board
            return state
            
        case .setNextTurn:
            switch state.turn {
            case .a:
                state.turn = .b
                
            case .b:
                state.turn = .a
            }
            return state
            
        case let .setGameEnded(gameResult):
            state.didGameEnd = gameResult
            return state
            
        case let .setError(error):
            state.error = error
            return state
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func actionPlace(at position: (row: Int, column: Int)) -> Observable<Mutation> {
        guard game.checkWinner() == nil else {
            // Guard to the game that already ended.
            return .empty()
        }
        
        do {
            // Place the game piece.
            try game.place(
                piece: currentState.turn,
                position: position
            )
            
            // Check the game result.
            let result = game.checkWinner()
            guard let result else {
                // Set only the board state  when the game not ended.
                return .concat(
                    .just(.setBoard(game.board)),
                    .just(.setNextTurn)
                )
            }
            
            return .concat(
                .just(.setBoard(game.board)),
                .just(.setNextTurn),
                .just(.setGameEnded(result))
            )
        } catch {
            return .just(.setError(error))
        }
    }
}
