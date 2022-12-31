//
//  ScoreboardViewReactor.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import ReactorKit
import Util
import Game

final class ScoreboardViewReactor: Reactor {
    enum Action {
        /// Update scoreboard with game result.
        case update(GameResult)
        /// Sign out.
        case signOut
    }
    
    enum Mutation {
        /// Set players.
        case setPlayers(Players)
        /// Set signed out.
        case setSignedOut
    }
    
    struct State {
        /// Players
        var players: Players
        /// Signed out event
        @Revision
        var didSignOut: Void?
    }
    
    // MARK: - Property
    private let gameService: any GameServiceable
    
    var initialState: State
    
    // MARK: - Initializer
    init(
        gameService: any GameServiceable,
        players: Players
    ) {
        self.gameService = gameService
        
        initialState = State(
            players: players
        )
    }
    
    // MARK: - Lifecycle
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .update(result):
            return actionUpdate(result)
            
        case .signOut:
            return acitonSignOut()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setPlayers(players):
            state.players = players
            return state
            
        case .setSignedOut:
            state.didSignOut = Void()
            return state
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func actionUpdate(_ result: GameResult) -> Observable<Mutation> {
        switch result {
        case let .end(winner):
            let players = currentState.players.won(piece: winner)
            return .just(.setPlayers(players))
            
        case .draw:
            return .empty()
        }
    }
    
    private func acitonSignOut() -> Observable<Mutation> {
        // Sign out
        gameService.signOut()
        
        return .just(.setSignedOut)
    }

    deinit {
        
    }
}
