//
//  GameServiceError.swift
//  
//
//  Created by JSilver on 2022/12/27.
//

import Foundation
import Resource

public enum GameServiceError: LocalizedError {
    case emptyPlayerName
    case samePlayerName
    
    public var errorDescription: String? {
        switch self {
        case .emptyPlayerName:
            return R.Localizable.gameGameServiceErrorEmptyPlayerNameMessage
            
        case .samePlayerName:
            return R.Localizable.gameGameServiceErrorSamePlayerNameMessage
        }
    }
}
