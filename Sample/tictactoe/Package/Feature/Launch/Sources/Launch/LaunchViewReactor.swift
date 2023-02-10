//
//  LaunchViewReactor.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import ReactorKit
import Game

final class LaunchViewReactor: Reactor {
    enum Action {
        /// Check luanch state.
        case launch
    }
    
    enum Mutation {
        /// Set launch completed.
        case setLaunchCompleted(LaunchState)
    }
    
    struct State {
        /// Launch completed event.
        @Pulse
        var launchCompleted: LaunchState?
    }
    
    // MARK: - Property
    var initialState: State
    
    private let gameService: any GameServiceable
    
    // MARK: - Initializer
    init(gameService: any GameServiceable) {
        self.gameService = gameService
        
        initialState = State()
    }
    
    // MARK: - Lifecycle
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .launch:
            return actionLaunch()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setLaunchCompleted(launchState):
            state.launchCompleted = launchState
            return state
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    private func actionLaunch() -> Observable<Mutation> {
        Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance)
            .map { [weak self] _ in self?.gameService.players }
            .map {
                // Check player already signed in.
                guard let players = $0 else { return .signedOut }
                return .signedIn(players: players)
            }
            .map { .setLaunchCompleted($0) }
    }
}
