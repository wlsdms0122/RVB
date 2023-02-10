//
//  LaunchState.swift
//  
//
//  Created by JSilver on 2022/12/27.
//

import Foundation
import Game

public enum LaunchState {
    /// Players already signed in.
    case signedIn(players: Players)
    /// Players not signed in.
    case signedOut
}
