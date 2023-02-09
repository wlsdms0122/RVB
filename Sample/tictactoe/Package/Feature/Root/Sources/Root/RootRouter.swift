//
//  RootRouter.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import RVB
import Launch
import SignedOut
import Scoreboard

protocol RootRoutable: Routable {
    /// Build `Launch` module for routing.
    func routeToLaunch(with parameter: LaunchParameter) -> any LaunchControllable
    /// Build `SignedOut` module for routing.
    func routeToSignedOut(with parameter: SignedOutParameter) -> any SignedOutControllable
    /// Build `Scoreboard` module for routing.
    func routeToScoreboard(with parameter: ScoreboardParameter) -> any ScoreboardControllable
}

final class RootRouter: RootRoutable {
    // MARK: - Property
    private let launchBuilder: any LaunchBuildable
    private let signedOutBuilder: any SignedOutBuildable
    private let scoreboardBuilder: any ScoreboardBuildable
    
    // MARK: - Initializer
    init(
        launchBuilder: any LaunchBuildable,
        signedOutBuilder: any SignedOutBuildable,
        scoreboardBuilder: any ScoreboardBuildable
    ) {
        self.launchBuilder = launchBuilder
        self.signedOutBuilder = signedOutBuilder
        self.scoreboardBuilder = scoreboardBuilder
    }
    
    // MARK: - Public
    
    // MARK: - Private
    func routeToLaunch(with parameter: LaunchParameter) -> any LaunchControllable {
        launchBuilder.build(with: parameter)
    }
    
    func routeToSignedOut(with parameter: SignedOutParameter) -> any SignedOutControllable {
        signedOutBuilder.build(with: parameter)
    }
    
    func routeToScoreboard(with parameter: ScoreboardParameter) -> any ScoreboardControllable {
        let controllable = scoreboardBuilder.build(with: parameter)
        return ScoreboardAdapter(controllable)
    }
}
