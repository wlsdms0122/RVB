//
//  SigningState.swift
//  
//
//  Created by JSilver on 2023/02/07.
//

import Foundation
import Game

public enum SigningState {
    /// Signed in as players.
    case signedIn(Players)
    /// Signed out.
    case signedOut
}
