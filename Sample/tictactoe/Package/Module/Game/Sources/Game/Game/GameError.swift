//
//  GameError.swift
//  
//
//  Created by JSilver on 2022/12/27.
//

import Foundation
import Resource

public enum GameError: LocalizedError {
    case invalidPosition
    
    public var errorDescription: String? {
        switch self {
        case .invalidPosition:
            return R.Localizable.gameGameErrorInvalidPositionMessage
        }
    }
}
