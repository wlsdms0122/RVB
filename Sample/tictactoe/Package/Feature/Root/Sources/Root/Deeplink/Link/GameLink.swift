//
//  GameLink.swift
//  
//
//  Created by JSilver on 2023/02/07.
//

import Foundation
import Deeplinker

/// Link to play game.
///
/// Route to `OnGame`. if not signed in, wait in `SignedOut` until signing.
/// and then play the game. If you add player names in query,
/// perform auto signing in if it doesn't match the current player.
///
/// **Route path**
/// ```
/// Root --- SignedOut
///   \         /
///    --- Scoreboard --- OnGame
/// ```
///
/// **URL**: ``tictactoe://game``
///
/// **Query**
/// - playerA: The player `A` name. (`playerB` required)
/// - playerB: The player `B` name. (`playerA` required)
///
/// **Example**
/// - ``tictactoe://game``
/// - ``tictactoe://game?playerA=tic&playerB=toe``
struct GameLink: Linkable {
    // MARK: - Property
    private weak var root: (any RootControllable)?
    
    var url: String { "tictactoe://game" }
    
    // MARK: - Initializer
    init(_ root: (any RootControllable)?) {
        self.root = root
    }
    
    // MARK: - Lifecycle
    func action(
        url: URL,
        parameter: Parameter,
        query: Query
    ) -> Bool {
        if let playerAName = query["playerA"],
           let playerBName = query["playerB"] {
            // If Added query about players.
            // Check current singing state.
            root?.checkSigningState { state in
                switch state  {
                case let .signedIn(players)
                    where players.playerA.name == playerAName
                    && players.playerB.name == playerBName:
                    // Players already signed in and match with query.
                    // Present to `Scoreboard`.
                    root?.presentScoreboard(
                        animated: true,
                        force: false,
                        players: players
                    ) { scoreboard in
                        // Present to `OnGame` after routing is complete.
                        scoreboard.presentOnGame(
                            animated: true,
                            force: true,
                            completion: nil
                        )
                    }
                    
                default:
                    // Any cases. It mean that signed out or not match players.
                    // Perform sign in using player names.
                    root?.signIn(
                        playerAName: playerAName,
                        playerBName: playerBName
                    ) { players in
                        // Present to `Scoreboard`.
                        root?.presentScoreboard(
                            animated: true,
                            force: false,
                            players: players
                        ) { scoreboard in
                            // Present to `OnGame` after routing is complete.
                            scoreboard.presentOnGame(
                                animated: true,
                                force: true
                            )
                        }
                    }
                }
            }
        } else {
            // Basic behavior.
            // Check current singing state.
            root?.checkSigningState { state in
                switch state {
                case let .signedIn(players):
                    // Players already signed.
                    // Present to `Scoreboard`.
                    root?.presentScoreboard(
                        animated: true,
                        force: false,
                        players: players
                    ) { scoreboard in
                        // Present to `OnGame` after routing is complete.
                        scoreboard.presentOnGame(
                            animated: true,
                            force: true,
                            completion: nil
                        )
                    }
                    
                case .signedOut:
                    // Signed out.
                    // Present to `SignedOut`.
                    root?.presentSignedOut(
                        animated: true,
                        force: false,
                        signedIn: { scoreboard in
                            // Present to `OnGame` after routing to `Scoreboard` through signed in is complete.
                            scoreboard.presentOnGame(
                                animated: true,
                                force: true,
                                completion: nil
                            )
                        }
                    )
                }
            }
        }
        
        return true
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
