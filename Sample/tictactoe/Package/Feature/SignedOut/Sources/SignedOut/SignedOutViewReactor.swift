//
//  SignedOutViewReactor.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import ReactorKit
import Game

final class SignedOutViewReactor: Reactor {
    enum Action {
        /// Update player `A`'s name.
        case updatePlayerAName(String)
        /// Update player `B`'s name.
        case updatePlayerBName(String)
        /// Sign in to play game.
        case signIn
    }
    
    enum Mutation {
        /// Set player `A`'s name.
        case setPlayerAName(String)
        /// Set player `B`'s name.
        case setPlayerBName(String)
        /// Set player signed in.
        case setSignedIn(Players)
        /// Set error.
        case setError(Error)
    }
    
    struct State {
        /// Player A name
        var playerAName: String
        /// Player B name
        var playerBName: String
        /// Player sigend in event
        @Pulse
        var didSignIn: Players?
        /// Error occur event
        @Pulse
        var error: Error?
    }
    
    // MARK: - Property
    private let gameService: any GameServiceable
    
    var initialState: State
    
    // MARK: - Initializer
    init(gameService: any GameServiceable) {
        self.gameService = gameService
        
        initialState = State(
            playerAName: "",
            playerBName: ""
        )
    }
    
    // MARK: - Lifecycle
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .updatePlayerAName(name):
            return actionUpdatePlayerAName(name)
            
        case let .updatePlayerBName(name):
            return actionUpdatePlayerBName(name)
            
        case .signIn:
            return actionSignIn()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setPlayerAName(name):
            state.playerAName = name
            return state
            
        case let .setPlayerBName(name):
            state.playerBName = name
            return state
            
        case let .setSignedIn(players):
            state.didSignIn = players
            return state
            
        case let .setError(error):
            state.error = error
            return state
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func actionUpdatePlayerAName(_ name: String) -> Observable<Mutation> {
        .just(.setPlayerAName(name))
    }
    
    private func actionUpdatePlayerBName(_ name: String) -> Observable<Mutation> {
        .just(.setPlayerBName(name))
    }
    
    private func actionSignIn() -> Observable<Mutation> {
        do {
            // Sign in.
            try gameService.signIn(
                playerAName: currentState.playerAName,
                playerBName: currentState.playerBName
            )
            
            guard let players = gameService.players else {
                return .just(.setError(SignedOutViewError.failToSignIn))
            }
            
            return .just(.setSignedIn(players))
        } catch {
            return .just(.setError(error))
        }
    }
}
