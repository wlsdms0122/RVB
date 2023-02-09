//
//  OnGameBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Game

public struct OnGameDependency: Dependency {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public struct OnGameParameter: Parameter {
    // MARK: - Property
    let players: Players
    
    // MARK: - Initializer
    public init(
        players: Players
    ) {
        self.players = players
    }
}

public protocol OnGameBuildable: Buildable {
    func build(with parameter: OnGameParameter) -> any OnGameControllable
}

public final class OnGameBuilder: Builder<OnGameDependency>, OnGameBuildable {
    public func build(with parameter: OnGameParameter) -> any OnGameControllable {
        let viewController = OnGameViewController()
        let reactor = OnGameViewReactor(
            players: parameter.players
        )
        let router = OnGameRouter()
        
        // DI
        viewController.reactor = reactor
        viewController.router = router
        
        return viewController
    }
}
