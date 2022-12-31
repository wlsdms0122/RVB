//
//  RootViewReactor.swift
//  
//
//  Created by JSilver on 2022/12/29.
//

import ReactorKit
import Game

// 로그인해서 플레이어 이름 주니깐안됨
final class RootViewReactor: Reactor {
    enum Action {
        /// Sign in.
        case signIn(String, String)
        /// Check signing state.
        case checkSigningState
    }
    
    enum Mutation {
        /// Send signed in signal.
        case setSignedIn(Players)
        /// Send checked signing state signal.
        case setCheckedSigningState(SigningState)
        /// Set error state.
        case setError(Error)
    }
    
    struct State {
        /// Signed in event.
        @Pulse
        var didSignIn: Players?
        /// Check result about sinigng state event.
        @Pulse
        var checkedSigningState: SigningState?
        /// Error
        @Pulse
        var error: Error?
    }
    
    // MARK: - Property
    private let gameService: any GameServiceable
    
    var initialState: State
    
    // MARK: - Initializer
    init(gameService: any GameServiceable) {
        self.gameService = gameService
        
        initialState = State()
    }
    
    // MARK: - Lifecycle
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .signIn(playerAName, playerBName):
            return actionSignIn(
                playerAName: playerAName,
                playerBName: playerBName
            )
            
        case .checkSigningState:
            return actionCheckSigningState()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setSignedIn(players):
            state.didSignIn = players
            return state
            
        case let .setCheckedSigningState(signingState):
            state.checkedSigningState = signingState
            return state
            
        case let .setError(error):
            state.error = error
            return state
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func actionSignIn(playerAName: String, playerBName: String) -> Observable<Mutation> {
        do {
            // Sign in
            try gameService.signIn(
                playerAName: playerAName,
                playerBName: playerBName
            )
            
            // Get signed in players.
            guard let players = gameService.players else {
                return .just(.setError(RootViewError.failToSignIn))
            }

            return .just(.setSignedIn(players))
        } catch {
            return .just(.setError(error))
        }
    }
    
    private func actionCheckSigningState() -> Observable<Mutation> {
        // Get current signed in players.
        guard let players = gameService.players else {
            return .just(.setCheckedSigningState(.signedOut))
        }
        return .just(.setCheckedSigningState(.signedIn(players)))
    }
}
