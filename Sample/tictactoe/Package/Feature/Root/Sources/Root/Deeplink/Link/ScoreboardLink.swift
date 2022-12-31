//
//  ScoreboardLink.swift
//  
//
//  Created by JSilver on 2023/02/07.
//

import Foundation
import Deeplinker

/// Link to show scoreboard.
///
/// Route to `Scoreboard`.
///
/// **Route path**
/// ```
/// Root --- Scoreboard
/// ```
/// 
/// **URL**: ``tictactoe://scoreboard``
///
/// **Example**
/// - ``tictactoe://scoreboard``
struct ScoreboardLink: Linkable {
    // MARK: - Property
    private weak var root: (any RootControllable)?
    
    var url: String { "tictactoe://scoreboard" }
    
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
        // Basic behavior.
        // Check current singing state.
        root?.checkSigningState { state in
            switch state {
            case let .signedIn(players):
                // Players already signed.
                // Present to `Scoreboard`.
                root?.presentScoreboard(
                    animated: true,
                    force: true,
                    players: players
                )
                
            default:
                break
            }
        }
        
        return true
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
