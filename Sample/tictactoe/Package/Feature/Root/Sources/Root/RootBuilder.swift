//
//  RootBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Launch
import SignedOut
import Scoreboard
import Game

public struct RootDependency: Dependency {
    // MARK: - Property
    let gameService: any GameServiceable
    
    // MARK: - Initializer
    public init(gameService: any GameServiceable) {
        self.gameService = gameService
    }
}

public struct RootParameter: Parameter {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public protocol RootBuildable: Buildable {
    func build(with parameter: RootParameter) -> any RootControllable
}

public final class RootBuilder: Builder<RootDependency>, RootBuildable {
    public func build(with parameter: RootParameter) -> any RootControllable {
        let viewController = RootViewController()
        let reactor = RootViewReactor(
            gameService: dependency.gameService
        )
        let router = RootRouter(
            launchBuilder: LaunchBuilder(
                .init(
                    gameService: dependency.gameService
                )
            ),
            signedOutBuilder: SignedOutBuilder(
                .init(
                    gameService: dependency.gameService,
                    deepinker: viewController
                )
            ),
            scoreboardBuilder: ScoreboardBuilder(
                .init(
                    gameService: dependency.gameService
                )
            )
        )
        
        viewController.reactor = reactor
        viewController.router = router
        
        return viewController
    }
}
