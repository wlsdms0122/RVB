//
//  LaunchBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Game

public struct LaunchDependency: Dependency {
    // MARK: - Property
    let gameService: any GameServiceable
    
    // MARK: - Initializer
    public init(gameService: any GameServiceable) {
        self.gameService = gameService
    }
}

public struct LaunchParameter: Parameter {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public protocol LaunchBuildable: Buildable {
    func build(with parameter: LaunchParameter) -> any LaunchControllable
}

public final class LaunchBuilder: Builder<LaunchDependency>, LaunchBuildable {
    public func build(with parameter: LaunchParameter) -> any LaunchControllable {
        let viewController = LaunchViewController()
        let reactor = LaunchViewReactor(
            gameService: dependency.gameService
        )
        let router = LaunchRouter()
        
        viewController.reactor = reactor
        viewController.router = router
        
        return viewController
    }
}
