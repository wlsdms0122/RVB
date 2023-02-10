//
//  SignedOutBuilder.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Deeplinker
import Game

public struct SignedOutDependency: Dependency {
    // MARK: - Property
    let gameService: any GameServiceable
    let deepinker: any Deeplinkable
    
    // MARK: - Initializer
    public init(
        gameService: any GameServiceable,
        deepinker: any Deeplinkable
    ) {
        self.gameService = gameService
        self.deepinker = deepinker
    }
}

public struct SignedOutParameter: RVB.Parameter {
    // MARK: - Property
    
    // MARK: - Initializer
    public init() { }
}

public protocol SignedOutBuildable: Buildable {
    func build(with parameter: SignedOutParameter) -> any SignedOutControllable
}

public final class SignedOutBuilder: Builder<SignedOutDependency>, SignedOutBuildable {
    public func build(with parameter: SignedOutParameter) -> any SignedOutControllable {
        let viewController = SignedOutViewController()
        let reactor = SignedOutViewReactor(
            gameService: dependency.gameService
        )
        let router = SignedOutRouter()
        
        viewController.reactor = reactor
        viewController.router = router
        viewController.deeplinker = dependency.deepinker
        
        return viewController
    }
}
