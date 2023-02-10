//
//  ScoreboardRouter.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import SwiftUI
import OnGame

protocol ScoreboardRoutable: Routable {
    /// Route to the `OnGame` module.
    func routeToOnGame(with parameter: OnGameParameter) -> any OnGameControllable
}

final class ScoreboardRouter: ScoreboardRoutable {
    // MARK: - Property
    private let onGameBuilder: any OnGameBuildable
    
    // MARK: - Initializer
    init(onGameBuilder: any OnGameBuildable) {
        self.onGameBuilder = onGameBuilder
    }
    
    // MARK: - Public
    
    // MARK: - Private
    func routeToOnGame(with parameter: OnGameParameter) -> any OnGameControllable {
        onGameBuilder.build(with: parameter)
    }
}
