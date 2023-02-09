//
//  RootViewController.swift
//  
//
//  Created by JSilver on 2022/12/03.
//

import UIKit
import Combine
import RVB
import Route
import Deeplinker
import ReactorKit
import RxSwift
import RxCocoa
import Game
import Launch
import SignedOut
import Scoreboard

public protocol RootControllable: UIViewControllable, Deeplinkable {
    /// Sign in via player names.
    func signIn(playerAName: String, playerBName: String, completion: @escaping (Players) -> ())
    /// Check current signing state.
    func checkSigningState(completion: @escaping (SigningState) -> Void)
    
    /// Present `SignedOut` module.
    func presentSignedOut(animated: Bool, force: Bool, signedIn: ((any ScoreboardControllable) -> Void)?, completion: ((any SignedOutControllable) -> Void)?)
    /// Present `Scoreboard` module.
    func presentScoreboard(animated: Bool, force: Bool, players: Players, completion: ((any ScoreboardControllable) -> Void)?)
}

public extension RootControllable {
    func presentSignedOut(animated: Bool, force: Bool = true, signedIn: ((any ScoreboardControllable) -> Void)? = nil, completion: ((any SignedOutControllable) -> Void)? = nil) {
        presentSignedOut(animated: animated, force: force, signedIn: signedIn, completion: completion)
    }
    
    func presentScoreboard(animated: Bool, force: Bool = true, players: Players, completion: ((any ScoreboardControllable) -> Void)? = nil) {
        presentScoreboard(animated: animated, force: force, players: players, completion: completion)
    }
}

final class RootViewController: UINavigationController, View, RootControllable {
    // MARK: - View

    // MARK: - Property
    var router: (any RootRoutable)?
    
    private var deeplinker: DeferredDeeplinkable?
    
    private let checkedSigningState = PublishRelay<SigningState>()
    private let didSignIn = PublishRelay<Players>()
    
    private var signedIn: ((any ScoreboardControllable) -> Void)?
    
    var disposeBag = DisposeBag()

    // MARK: - Initializer

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func bind(reactor: RootViewReactor) {
        // MARK: State
        // Checked signing state signal
        reactor.pulse(\.$checkedSigningState)
            .compactMap { $0 }
            .bind(to: checkedSigningState)
            .disposed(by: disposeBag)
        
        // Signed in signal
        reactor.pulse(\.$didSignIn)
            .compactMap { $0 }
            .bind(to: didSignIn)
            .disposed(by: disposeBag)

        // MARK: Action
    }

    // MARK: - Public
    func handle(url: URL) -> Bool {
        deeplinker?.handle(url: url) ?? false
    }
    
    func signIn(
        playerAName: String,
        playerBName: String,
        completion: @escaping (Players) -> ()
    ) {
        guard let reactor else { return }
        
        _ = didSignIn
            .take(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { completion($0) })
        
        reactor.action.onNext(.signIn(playerAName, playerBName))
    }
    
    func checkSigningState(
        completion: @escaping (SigningState) -> Void
    ) {
        guard let reactor else { return }
        
        _ = checkedSigningState
            .take(1)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { completion($0) })
        
        reactor.action.onNext(.checkSigningState)
    }
    
    func presentSignedOut(
        animated: Bool,
        force: Bool,
        signedIn: ((any ScoreboardControllable) -> Void)?,
        completion: ((any SignedOutControllable) -> Void)?
    ) {
        self.signedIn = signedIn
        
        if let signedOut = search(where: { $0 is any SignedOutControllable })
            .last as? any SignedOutControllable {
            guard force else {
                completion?(signedOut)
                return
            }
            
            route(signedOut, animated: animated) {
                guard let signedOut = $0 as? any SignedOutControllable else { return }
                completion?(signedOut)
            }
            return
        }
        
        guard let signedOut = router?.routeToSignedOut(
            with: .init()
        )
        else { return }
        
        // Signed in
        signedOut.signedIn
            .subscribe(onNext: { [weak self] in
                self?.presentScoreboard(
                    animated: true,
                    players: $0
                ) {
                    self?.signedIn?($0)
                }
            })
            .disposed(by: signedOut.disposeBag)
        
        route(self, animated: animated) {
            guard let root = $0 as? UINavigationController else { return }
            root.setViewControllers([signedOut], animated: animated)
            completion?(signedOut)
        }
    }
    
    func presentScoreboard(
        animated: Bool,
        force: Bool,
        players: Players,
        completion: ((any ScoreboardControllable) -> Void)?
    ) {
        if let scoreboard = search(
            where: {
                guard let scoreboard = $0 as? any ScoreboardControllable else { return false }
                return scoreboard.players == players
            }
        )
            .last as? any ScoreboardControllable {
            guard force else {
                completion?(scoreboard)
                return
            }
            
            route(scoreboard, animated: animated) {
                guard let scoreboard = $0 as? any ScoreboardControllable else { return }
                completion?(scoreboard)
            }
            return
        }
        
        guard let scoreboard = router?.routeToScoreboard(
            with: .init(players: players)
        )
        else { return }
        
        // Signed out
        scoreboard.signedOut
            .subscribe(onNext: { [weak self] in
                // Route to signed out.
                self?.presentSignedOut(animated: true)
            })
            .disposed(by: scoreboard.disposeBag)
        
        route(self, animated: animated) {
            guard let root = $0 as? UINavigationController else { return }
            root.setViewControllers([scoreboard], animated: animated)
            completion?(scoreboard)
        }
    }
    
    // MARK: - Private
    private func setUp() {
        setUpLayout()
        setUpState()
        setUpAction()
    }
    
    private func setUpLayout() {
        
    }
    
    private func setUpState() {
        // Hide top navigtaion bar
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
        
        // Set deeplinker
        deeplinker = DeeplinkController(root: self, canHandler: false)
        
        // Route to launch first.
        presentLaunch(animated: false)
    }
    
    private func setUpAction() {
        
    }
    
    private func presentLaunch(
        animated: Bool,
        force: Bool = true,
        completion: ((any LaunchControllable) -> Void)? = nil
    ) {
        guard let launch = router?.routeToLaunch(
            with: .init()
        )
        else { return }
        
        // Launch compeleted
        launch.completed
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .signedOut:
                    // Route to signed out.
                    self?.presentSignedOut(
                        animated: true,
                        completion: { _ in
                            self?.delegate = nil
                        }
                    )
                    
                case let .signedIn(players):
                    // Route to scoreboard.
                    self?.presentScoreboard(
                        animated: true,
                        players: players
                    ) { _ in
                        self?.delegate = nil
                    }
                }
                
                // Handle deferred deeplink if it exist.
                self?.deeplinker?.handle()
            })
            .disposed(by: launch.disposeBag)
        
        delegate = launch
        
        route(self, animated: animated) {
            guard let root = $0 as? UINavigationController else { return }
            root.viewControllers = [launch]
            completion?(launch)
        }
    }
}

extension RootViewController: UIGestureRecognizerDelegate {
    // when a gesture recognizer attempts to transition out of the UIGestureRecognizer.State.possible state
    // Returning false causes the gesture recognizer to transition to the UIGestureRecognizer.State.failed state.
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        false
    }
    
    // when return false (default is true), gesture recognizer doesn't notified touch event accured
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        true
    }
}
