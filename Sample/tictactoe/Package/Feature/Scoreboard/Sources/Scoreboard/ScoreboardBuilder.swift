//
//  ScoreboardBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import SwiftUI
import Combine
import RVB
import Game
import OnGame

public struct ScoreboardDependency: Dependency {
    // MARK: - Property
    let gameService: any GameServiceable
    
    // MARK: - Initializer
    public init(gameService: any GameServiceable) {
        self.gameService = gameService
    }
}

public struct ScoreboardParameter: Parameter {
    // MARK: - Property
    let players: Players
    let shouldOnGameRoute: Binding<Players?>?
    
    // MARK: - Initializer
    public init(
        players: Players,
        shouldOnGameRoute: Binding<Players?>? = nil
    ) {
        self.players = players
        self.shouldOnGameRoute = shouldOnGameRoute
    }
}

public protocol ScoreboardBuildable: Buildable {
    func build(with parameter: ScoreboardParameter) -> any ScoreboardControllable
}

public final class ScoreboardBuilder: Builder<ScoreboardDependency>, ScoreboardBuildable {
    public func build(with parameter: ScoreboardParameter) -> any ScoreboardControllable {
        let router = ScoreboardRouter(
            onGameBuilder: OnGameBuilder(
                .init()
            )
        )
        let reactor = ScoreboardViewReactor(
            gameService: dependency.gameService,
            players: parameter.players
        )
        let viewController = ScoreboardViewController(
            router: router,
            reactor: reactor
        )
        
        return viewController
    }
}
