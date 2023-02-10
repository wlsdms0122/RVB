//
//  ScoreboardAdapter.swift
//  
//
//  Created by JSilver on 2023/02/09.
//

import SwiftUI
import Combine
import RVB
import RxSwift
import RxCocoa
import Game
import Scoreboard
import OnGame

public protocol ScoreboardControllable: UIViewControllable {
    var players: Players { get }
    
    var signedOut: Observable<Void> { get }
    
    var disposeBag: DisposeBag { get }
    
    func presentOnGame(animated: Bool, force: Bool, completion: ((any OnGameControllable) -> Void)?)
}

extension ScoreboardControllable {
    func presentOnGame(animated: Bool, force: Bool = true, completion: ((any OnGameControllable) -> Void)? = nil) {
        presentOnGame(animated: animated, force: force, completion: completion)
    }
}

class ScoreboardAdapter: UIViewController, ScoreboardControllable {
    // MARK: - Property
    private let viewController: Scoreboard.ScoreboardControllable
    
    var players: Players { viewController.players }
    
    var signedOut: Observable<Void>
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(_ viewController: Scoreboard.ScoreboardControllable) {
        let signedOut = PublishRelay<Void>()
        
        viewController.signedOut
            .sink { signedOut.accept($0) }
            .store(in: &viewController.cancellableBag)
        
        self.viewController = viewController
        self.signedOut = signedOut.asObservable()
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(viewController)
        view.addSubview(viewController.view)        
        viewController.didMove(toParent: self)
        viewController.view.frame = view.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    func presentOnGame(animated: Bool, force: Bool, completion: ((OnGame.OnGameControllable) -> Void)?) {
        viewController.presentOnGame(animated: animated, force: force, completion: completion)
    }
    
    // MARK: - Private
}
