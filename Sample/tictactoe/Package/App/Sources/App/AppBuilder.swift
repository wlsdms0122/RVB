//
//  AppBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Root
import Game

public struct AppDependency {
    // MARK: - Property
    let gameService: any GameServiceable
    
    // MARK: - Initializer
    public init() {
        gameService = GameService(userDefault: .standard)
    }
}

public struct AppParameter {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public protocol AppBuildable: Buildable {
    func build(with parameter: AppParameter) -> any AppControllable
}

public final class AppBuilder: Builder<AppDependency>, AppBuildable {
    public func build(with parameter: AppParameter) -> any AppControllable {
        let router = AppRouter(
            rootBuilder: RootBuilder(
                .init(
                    gameService: dependency.gameService
                )
            )
        )
        let app = App(router: router)
        
        return app
    }
}
