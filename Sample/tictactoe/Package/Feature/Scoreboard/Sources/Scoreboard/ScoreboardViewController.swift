//
//  ScoreboardViewController.swift
//  
//
//  Created by JSilver on 2023/02/03.
//

import SwiftUI
import RVB
import Compose
import RxSwift
import RxCocoa
import Route
import Util
import Game
import Resource
import OnGame

public protocol ScoreboardControllable: UIViewControllable {
    var players: Players { get }
    
    var signedOut: Observable<Void> { get }
    
    var disposeBag: DisposeBag { get }
    
    func presentOnGame(animated: Bool, force: Bool, completion: ((any OnGameControllable) -> Void)?)
}

public extension ScoreboardControllable {
    func presentOnGame(animated: Bool, force: Bool = false, completion: ((any OnGameControllable) -> Void)? = nil) {
        presentOnGame(animated: animated, force: force, completion: completion)
    }
}

public class ScoreboardViewController: ComposableController, ScoreboardControllable {
    // MARK: - Property
    private let router: any ScoreboardRoutable
    private let reactor: PublishedReactor<ScoreboardViewReactor>
    
    public var players: Players { reactor.state.players }
    
    public let signedOut: Observable<Void>
    
    public let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(
        router: any ScoreboardRoutable,
        reactor: ScoreboardViewReactor
    ) {
        self.router = router
        
        let reactor = reactor.publisher
        self.reactor = reactor
        
        let signedOut = PublishRelay<Void>()
        self.signedOut = signedOut.asObservable()
        
        super.init(reactor)
        
        run { [weak self] in
            /// Players
            let players: Players = reactor.state.players
            /// Leader player
            let leader: Player? = {
                if players.playerA.score > players.playerB.score {
                    return players.playerA
                } else if players.playerA.score < players.playerB.score {
                    return players.playerB
                } else {
                    return nil
                }
            }()
            
            Root(
                leader: leader,
                players: players
            ) {
                self?.presentOnGame(animated: true)
            } onSignOutTap: {
                reactor.action.send(.signOut)
            }
                .subscribe(
                    reactor.$state.map(\.$didSignOut)
                        .removeDuplicates()
                        .compactMap(\.value)
                ) {
                    signedOut.accept(Void())
                }
        }
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    public func presentOnGame(
        animated: Bool,
        force: Bool,
        completion: ((any OnGameControllable) -> Void)?
    ) {
        let onGame = router.routeToOnGame(
            with: .init(players: players)
        )
        
        // On game
        Observable.merge(
            onGame.exit,
            onGame.gameEnded
                .map { _ in }
        )
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.navigationController?.popToViewController(self, animated: true)
            })
            .disposed(by: disposeBag)
        
        onGame.gameEnded
            .map { .update($0) }
            .subscribe(onNext: { [weak self] in
                self?.reactor.action.send($0)
            })
            .disposed(by: disposeBag)
        
        
        route(self, animated: animated) {
            $0?.navigationController?.pushViewController(onGame, animated: animated)
            completion?(onGame)
        }
    }
    
    // MARK: - Private
}

@ViewBuilder
private func Root(
    leader: Player?,
    players: Players,
    onPlayTap: @escaping () -> Void,
    onSignOutTap: @escaping () -> Void
) -> some View {
    VStack {
        Spacer()
        
        Scoreboard(
            leader: leader,
            players: players
        )
        
        Spacer()
        
        Footer(
            onPlayTap: onPlayTap,
            onSignOutTap: onSignOutTap
        )
    }
        .padding(16)
}

@ViewBuilder
private func Scoreboard(
    leader: Player?,
    players: Players
) -> some View {
    VStack {
        ScoreboardHeader(leader: leader)
        
        Dashboard(
            players: players,
            leader: leader
        )
            .padding([.top])
    }
        .padding(.bottom, 64)
}

@ViewBuilder
private func Footer(
    onPlayTap: @escaping () -> Void,
    onSignOutTap: @escaping () -> Void
) -> some View {
    VStack {
        Button {
            onPlayTap()
        } label: {
            Text(R.Localizable.scoreboardPlayGameButtonTitle)
                .frame(maxWidth: .infinity, maxHeight: 34)
        }
        .buttonStyle(.borderedProminent)
        
        Button {
            onSignOutTap()
        } label: {
            Text(R.Localizable.scoreboardSignOutButtonTitle)
                .frame(maxWidth: .infinity, maxHeight: 34)
        }
    }
}

#if DEBUG
class OnGameViewControllerMock: UIViewController, OnGameControllable {
    var disposeBag = DisposeBag()
    
    var exit: Observable<Void> { .empty() }
    var gameEnded: Observable<GameResult> { .empty() }
}

class ScoreboardRouterMock: ScoreboardRoutable {
    func routeToOnGame(with parameter: OnGameParameter) -> any OnGameControllable {
        OnGameViewControllerMock()
    }
}

class GameServiceMock: GameServiceable {
    private(set) var players: Players?
    
    func signIn(playerAName: String, playerBName: String) throws {
        
    }
    
    func signOut() {
        
    }
    
    func win(piece: GamePiece) throws {
        
    }
}

struct ScoreboardProvider_Previews: PreviewProvider {
    static var previews: some View {
        ScoreboardViewController(
            router: ScoreboardRouterMock(),
            reactor: ScoreboardViewReactor(
                gameService: GameServiceMock(),
                players: .init(
                    playerA: .init(
                        name: "A",
                        score: 0
                    ),
                    playerB: .init(
                        name: "B",
                        score: 0
                    )
                )
            )
        )
            .rootView
    }
}

#endif
